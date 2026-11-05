#!/usr/bin/env python3
"""Update the CoCo-Pi Raspberry Pi image through its small public release channel."""
import argparse
from datetime import datetime, timezone
import fcntl
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import platform
import shutil
import subprocess
import tarfile
import tempfile
import urllib.parse
import urllib.request

REPOSITORY = "https://github.com/mrgw454/CoCo-Pi"
MANIFEST_URL = "https://raw.githubusercontent.com/mrgw454/CoCo-Pi/main/cocopi-release.json"
DOWNLOAD_PREFIX = "https://downloads.coco-pi.net/coco-pi/updates/"


def validate_download_url(url):
    parsed=urllib.parse.urlsplit(url)
    if not url.startswith(DOWNLOAD_PREFIX) or parsed.scheme != 'https' or parsed.hostname != 'downloads.coco-pi.net' or parsed.port not in (None,443) or parsed.username or parsed.password or parsed.query or parsed.fragment or '..' in urllib.parse.unquote(parsed.path).split('/'):
        raise ValueError('Unsupported update download URL')
    return url


def load_release(path, remote=False):
    release=json.loads(path.read_text())
    if release.get('schema') != 1 or type(release.get('sequence')) is not int or not isinstance(release.get('name'),str):
        raise ValueError('Unsupported CoCo-Pi release manifest')
    if set(release.get('payloads',{})) != {'scripts.tar.gz','source.tar.gz'}:
        raise ValueError('Unexpected CoCo-Pi payload set')
    if not isinstance(release.get('changes',[]),list) or not all(isinstance(x,str) for x in release.get('changes',[])):
        raise ValueError('Invalid release change list')
    for digest in release['payloads'].values():
        if not isinstance(digest,str) or len(digest)!=64 or any(x not in '0123456789abcdef' for x in digest):
            raise ValueError('Invalid payload checksum')
    if remote:
        if release.get('update_repository') != REPOSITORY or release.get('update_branch') != 'main':
            raise ValueError('Release does not belong to the CoCo-Pi main update channel')
        if set(release.get('downloads',{})) != set(release['payloads']):
            raise ValueError('Missing update download URLs')
        for url in release['downloads'].values(): validate_download_url(url)
        for fix in release.get('fixes',[]):
            path=PurePosixPath(fix['script'])
            if path.is_absolute() or '..' in path.parts or path.parts[:2] != ('scripts','cocopi-fixes') or not fix['id'].startswith('fix-'):
                raise ValueError('Unsupported fix entry')
    return release


def record_update(home, release, previous=None, event='release-applied', fix=None):
    journal=home/'update/cocopi-updates.jsonl';journal.parent.mkdir(parents=True,exist_ok=True)
    entry={'timestamp':datetime.now(timezone.utc).isoformat(),'event':event,
           'sequence':release['sequence'],'name':release['name'],
           'launcher_revision':release.get('launcher_revision'),'payloads':release['payloads'],
           'previous_sequence':(previous or {}).get('sequence'),'repository':REPOSITORY}
    if fix:entry['fix']=fix
    with journal.open('a') as stream:stream.write(json.dumps(entry,sort_keys=True)+'\n')


def validate_archive(archive):
    with tarfile.open(archive) as stream:
        members = stream.getmembers()
        root = "scripts" if archive.name == "scripts.tar.gz" else "source"
        seen=set()
        if len(members)>50000 or sum(m.size for m in members)>1024*1024*1024:
            raise ValueError("Update archive exceeds its limits")
        for member in members:
            path = PurePosixPath(member.name)
            if path.is_absolute() or ".." in path.parts or not path.parts or path.parts[0] != root:
                raise ValueError(f"Unsafe payload path: {member.name}")
            if path.as_posix() in seen:
                raise ValueError("Duplicate update path: " + member.name)
            seen.add(path.as_posix())
            if not (member.isfile() or member.isdir()):
                raise ValueError(f"Unsupported payload entry: {member.name}")
        return members


def apply_payloads(repo, home, release, check=False):
    installed_path = home / "cocopi-release.json"
    installed = None
    if installed_path.exists():
        installed = load_release(installed_path)
        if release["sequence"] < installed["sequence"]:
            raise ValueError("Update channel is older than this image; refusing a downgrade")
    for name, expected in release["payloads"].items():
        path = repo / name
        with path.open("rb") as stream:
            digest = hashlib.file_digest(stream, "sha256").hexdigest()
        if digest != expected:
            raise ValueError(f"Checksum mismatch: {name}")
        validate_archive(path)
    # A sequence identifies immutable payloads. Changed metadata at the same
    # sequence must never become an implicit reinstall over a running system.
    if installed is not None and release["sequence"] == installed["sequence"] and release != installed:
        raise ValueError("Release identity changed at the installed sequence; refusing to overwrite runtime files")
    print(f"Validated {release['name']}", flush=True)
    print("Installed: " + (installed["name"] if installed else "no versioned release"), flush=True)
    for change in release.get("changes", []):
        print("  - " + change, flush=True)
    if check:
        return
    if installed == release:
        print("This CoCo-Pi release is already installed; local runtime customizations were preserved.")
        return
    with tempfile.TemporaryDirectory(prefix="cocopi-stage-", dir=home) as tmp:
        stage = Path(tmp)
        for name in release["payloads"]:
            with tarfile.open(repo / name) as stream:
                # The image retains Python3.11.2 for legacy tools. Avoid the
                # newer tarfile filter API; only validated directories/files
                # are extracted, with no links or special permission bits.
                for member in validate_archive(repo / name):
                    target = stage / member.name
                    if member.isdir():
                        target.mkdir(parents=True, exist_ok=True)
                    else:
                        target.parent.mkdir(parents=True, exist_ok=True)
                        with stream.extractfile(member) as source, target.open("wb") as output:
                            shutil.copyfileobj(source, output)
                        target.chmod(member.mode & 0o777)
        # Local symlink customizations must not redirect a managed write elsewhere.
        for root in ('scripts','source'):
            for incoming in (stage/root).rglob('*'):
                relative=incoming.relative_to(stage)
                target=home
                for part in relative.parts:
                    target=target/part
                    if target.is_symlink():
                        raise ValueError('Preserve local managed symlink before updating: '+str(target))
        # Preserve unrelated files and a versioned rollback for each applied release.
        rollback = home / "update" / "rollback"
        rollback.mkdir(parents=True, exist_ok=True)
        backup = rollback / (str((installed or {}).get("sequence", "unversioned")) + "-before-" + str(release["sequence"]) + ".tar.gz")
        backup.parent.mkdir(parents=True, exist_ok=True)
        with tarfile.open(backup.with_suffix(".tmp"), "w:gz") as stream:
            for relative in ("scripts/launcher", "scripts/update-cocopi.py", "cocopi-release.json", "cocopi-release.txt"):
                old = home / relative
                if old.exists():
                    stream.add(old, arcname=relative)
            for root in ("scripts", "source"):
                for incoming in (stage / root).rglob("*"):
                    relative = incoming.relative_to(stage)
                    if incoming.is_file() and not relative.is_relative_to("scripts/launcher") and (home / relative).exists():
                        stream.add(home / relative, arcname=str(relative), recursive=False)
        if backup.exists():
            backup.with_suffix(".tmp").unlink()
        else:
            backup.with_suffix(".tmp").replace(backup)
        shutil.copy2(backup, home / "update" / "launcher-before-update.tar.gz")
        for root in ("scripts", "source"):
            shutil.copytree(stage / root, home / root, dirs_exist_ok=True)
        # Identity is written last, after every managed file is copied successfully.
        shutil.copy2(repo / "cocopi-release.txt", home / "cocopi-release.txt")
        temporary_identity = installed_path.with_suffix(".tmp")
        shutil.copy2(repo / "cocopi-release.json", temporary_identity)
        temporary_identity.replace(installed_path)
    record_update(home, release, installed)
    print("CoCo-Pi Launcher and build recipes updated.", flush=True)


def download(url,target,expected=None):
    request=urllib.request.Request(url,headers={'User-Agent':'CoCo-Pi-Updater/2026.11'})
    with urllib.request.urlopen(request,timeout=120) as response,target.open('wb') as output:
        if url != MANIFEST_URL: validate_download_url(response.url)
        total=0
        while chunk:=response.read(1024*1024):
            total+=len(chunk)
            if total>512*1024*1024:raise ValueError('Update download exceeds its limit')
            output.write(chunk)
    if expected:
        with target.open('rb') as stream:
            if hashlib.file_digest(stream,'sha256').hexdigest()!=expected:
                raise ValueError('Checksum mismatch: '+target.name)


def apply_fixes(home, release):
    ledger=home/'update/cocopi-fixes.txt';ledger.parent.mkdir(parents=True,exist_ok=True)
    done=set(ledger.read_text().splitlines()) if ledger.exists() else set()
    for fix in release.get('fixes',[]):
        script=home/fix['script']
        if hashlib.sha256(script.read_bytes()).hexdigest()!=fix['sha256']:
            raise ValueError('Fix script differs from this release: '+fix['id'])
        checked=subprocess.run(['bash',str(script),'--check'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0
        if fix['id'] in done and checked:
            print('Already complete: '+fix['id']+' — '+fix['description'],flush=True)
            continue
        print('Applying '+fix['id']+' — '+fix['description'],flush=True)
        result=subprocess.run(['bash',str(script)],env={**os.environ,'HOME':str(home)})
        if result.returncode:
            raise ValueError('FAILED: '+fix['id']+'; not marked complete. Correct the error and retry Apply CoCo-Pi Fixes.')
        if subprocess.run(['bash',str(script),'--check'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode:
            raise ValueError('FAILED post-install check: '+fix['id']+'; not marked complete')
        record_update(home,release,event='fix-applied',fix=fix['id'])
        if fix['id'] not in done:
            with ledger.open('a') as stream:stream.write(fix['id']+'\n')
            done.add(fix['id'])
        print('Applied: '+fix['id'],flush=True)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check',action='store_true',help='Validate available updates without deploying')
    parser.add_argument('--fixes',action='store_true',help='Also apply reviewed numbered fixes')
    args=parser.parse_args()
    if not args.check:
        model=Path('/proc/device-tree/model')
        if platform.system()!='Linux' or platform.machine() not in ('aarch64','arm64') or not model.is_file() or b'Raspberry Pi' not in model.read_bytes():
            raise ValueError('This update channel is for 64-bit Raspberry Pi CoCo-Pi images; use CoCo-Pi-Installer on workstations')
    home=Path.home();cache=home/'.cache/cocopi';cache.mkdir(parents=True,exist_ok=True)
    with (cache/'update.lock').open('a') as lock:
        fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
        with tempfile.TemporaryDirectory(prefix='cocopi-download-',dir=cache) as tmp:
            stage=Path(tmp);manifest=stage/'cocopi-release.json'
            download(MANIFEST_URL,manifest)
            release=load_release(manifest,remote=True)
            installed=load_release(home/'cocopi-release.json') if (home/'cocopi-release.json').exists() else None
            if installed and release['sequence']<installed['sequence']:
                raise ValueError('Available update is older than the installed release; refusing downgrade')
            if installed and release['sequence']==installed['sequence'] and release!=installed:
                raise ValueError('Release changed at the installed sequence; refusing overwrite')
            if installed==release and not args.check:
                print('Already installed: '+release['name'],flush=True)
            else:
                print('Available: '+release['name'],flush=True)
                for change in release.get('changes',[]):print('  - '+change,flush=True)
                for name,digest in release['payloads'].items():download(release['downloads'][name],stage/name,digest)
                (stage/'cocopi-release.txt').write_text(release['name']+'\n')
                apply_payloads(stage,home,release,args.check)
            if args.fixes and not args.check:apply_fixes(home,release)
    print('Check complete; nothing installed.' if args.check else 'CoCo-Pi update complete. Reboot only if a specific fix asks for it.')


if __name__=='__main__':
    try:main()
    except (OSError,ValueError,KeyError,subprocess.CalledProcessError) as error:
        raise SystemExit('CoCo-Pi update stopped: '+str(error))
