# CoCo-Pi

CoCo-Pi Community Edition brings Color Computer, Dragon and MC-10 emulators,
software and development tools to Raspberry Pi OS. It is separate from the
BMCoCo-Pi bare-metal project.

**Website, image downloads and user guide:** [coco-pi.net](https://coco-pi.net/).
See the [CoCo-Pi guide](https://coco-pi.net/docs/coco-pi/user-guide) for setup,
ROM acquisition, optional downloads, VS Code and everyday use.
Read the [changelog and numbered fixes](https://coco-pi.net/docs/coco-pi/changelog)
for release changes and fix-specific instructions.

This small repository provides the public update channel. Runtime archives and
selected emulator packages are hosted on downloads.coco-pi.net; their SHA256
checksums are in the release manifest and package catalogue. Image assembly
and maintainer development repositories are separate.

## Update an installed image

Choose **Maintenance: Update Utilities → Update CoCo-Pi Launcher and Build
Scripts**, or **Apply CoCo-Pi Fixes** to include numbered fixes. Updates explain
what changes and preserve unrelated user files. A current release is a no-op.
To check without deploying:

```sh
python3 ~/scripts/update-cocopi.py --check
```

Completed updates: `~/update/cocopi-updates.jsonl`. Numbered fixes:
`~/update/cocopi-fixes.txt`. Versioned runtime backups: `~/update/rollback/`.
These backups do not undo OS package changes. Build-script updates do not
automatically rebuild installed compilers; see [CHANGELOG.md](CHANGELOG.md).
Raspberry Pi OS updates remain separate: `sudo apt update` and
`sudo apt full-upgrade`. Save work and reboot when an OS update requires it.

## NitrOS-9 EOU

Run **Apply CoCo-Pi Fixes** for the refreshed Linux MAME/XRoar EOU entries.
Optional EOU media and ROMs remain separate downloads. See the
[EOU guide](https://coco-pi.net/docs/coco-pi/nitros9-eou) for preparation,
DriveWire settings, outgoing sessions and incoming Telnet limitations.
No new SD image is needed.

## bcc09 in a terminal

Run **Apply CoCo-Pi Fixes** to install bcc09, then use `bcc09` from a terminal
or VS Code's integrated terminal. Its companion utilities have `bcc09-`
prefixes, preserving existing assembler and simulator commands. This adds no
Launcher menu or VS Code task. See the [terminal example](https://coco-pi.net/docs/coco-pi/user-guide#use-bcc09-in-a-terminal)
and [release notes](CHANGELOG.md).

## Recover an older update entry point

For a supported 64-bit Raspberry Pi CoCo-Pi image, save your work, open a terminal,
and download the updater plus checksum into a temporary folder:

```sh
mkdir -p /tmp/cocopi-updater
cd /tmp/cocopi-updater
curl -fL https://raw.githubusercontent.com/mrgw454/CoCo-Pi/main/update-cocopi.py -o update-cocopi.py
curl -fL https://raw.githubusercontent.com/mrgw454/CoCo-Pi/main/update-cocopi.py.sha256 -o update-cocopi.py.sha256
sha256sum -c update-cocopi.py.sha256
```

Only after the checksum succeeds, run `python3 update-cocopi.py --fixes`.
The installed menu then uses `~/scripts/update-cocopi.py`.

For general Debian/x86 or Windows component installations, continue using
[CoCo-Pi-Installer](https://github.com/mrgw454/CoCo-Pi-Installer); this image
update channel is for 64-bit Raspberry Pi systems.
