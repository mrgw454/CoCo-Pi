# CoCo-Pi updates

## 2026111103 — bcc09 terminal development tools — 2026-11-11

Run **Apply CoCo-Pi Fixes** to install John Linville's bcc09 0.11.0 through
`fix-20261111-02`. Leave the terminal open while the compiler builds and runs
its checks. Then use `bcc09` in a terminal or VS Code's integrated terminal.

Companion tools are named `bcc09-as09`, `bcc09-ld09`, `bcc09-ar09`,
`bcc09-objdump09`, `bcc09-objcopy09`, `bcc09-nm09` and `bcc09-size09`.
Existing `as09`, `sim6809` and other toolchains are preserved. Installation
stops if one of the new command names belongs to another installation; move
that conflicting command aside deliberately or use a separate prefix.

The compiler, target libraries, manuals and source use a versioned install
layout. No Launcher menu or task is added. No reboot, reflash or new SD image
is required. Failed fixes are not marked complete; retry through the same
update action after correcting the reported error.
[Terminal example](https://coco-pi.net/docs/coco-pi/user-guide#use-bcc09-in-a-terminal).

## 2026111102 — YA-DOS ROM correction — 2026-11-11

Run **Apply CoCo-Pi Fixes**. The initial CHDX update requested
`yados-0.5d.rom`, but the previous ROM archive supplied only an older
`yados.rom`. This could leave CoCo3 at BASIC or CoCo2 with an unusable screen.

Fix `fix-20261111-01` updates the shipped ROM download setting and installs
verified YA-DOS 0.5D when ROMs were already downloaded. It preserves the old
ROMs and backs up the setting. Custom firmware/settings are preserved and
reported for manual attention. If ROMs were not downloaded, **Download ROMs**
now supplies 0.5D. **Update CHDX HDD** also prepares the required firmware.

No HDD redownload, MPI change, reboot or SD-card reflash is needed.
[CHDX setup and recovery](https://coco-pi.net/docs/coco-pi/chdx).

## 2026111101 — CHDX hard-drive browser — 2026-11-11

Choose **Update CoCo-Pi Launcher and Build Scripts**, then reopen the Launcher.
The seven CoCo2/CoCo3 YA-DOS HDD choices now use CHDX 0.1.0 in MAME and XRoar.
Choose **Update CHDX HDD (CoCo HD Explorer)** to install the optional matched
3,280-disk library. YA-DOS 0.5D ROM is separate; DriveWire is not required.

Browse titles, switch title/number order, search prefixes and run BASIC/BIN
programs. Legacy HDDs are preserved; customized CHDX images are backed up
before replacement. The catalog must be rebuilt after library changes. No
reboot or SD-card reflash is needed, and no new numbered system fix is added.
[Setup and controls](https://coco-pi.net/docs/coco-pi/chdx).

## 2026110603 — MCX128 firmware and curated builders — 2026-11-06

Run **Apply CoCo-Pi Fixes**. New `fix-20261106-03` prepares the verified16KB
MCX128 raw ROM for XRoar from ROM files you already downloaded. It preserves
MAME ZIPs and existing custom raw ROM files. If ROMs have not been downloaded,
the optional step is deferred and a future DownloadROMs run prepares it.

The MC-10 MCX128 entry should show its boot menu. Choose1 or2 and allow
initialization before typing BASIC commands. No emulator rebuild, reboot or
SD card reflash is required. The Launcher audit detects ZIP-only firmware gaps.

The manual `make-ALL-packages.sh` includes stable ugBASIC and PL/M-09 and selects
BASIC-To-6809 for ARM64 or x86_64. Optional omitted builders remain optional;
the optional RAMCHK64 helper has a corrected prerequisite message. Earlier
TNFS/printer/development-tool fixes remain recognized when already complete.

## 2026110601 — RC6 numbered additions — 2026-11-06

Run **Apply CoCo-Pi Fixes**; leave the terminal open until it finishes.
No reboot or SD card reflash is required.

- `fix-20261106-01` disables unwanted automatic USB printer setup while
  preserving CUPS and manual printing. Restore automatic setup with
  `sudo systemctl unmask configure-printer@.service`; a later Apply Fixes run
  will enforce the disabled default again.
- `fix-20261106-02` installs MC6801 tools v1.2.0 and PL/M-09 0.4.2 with
  native regression checks, manuals/runtime hooks and recorded provenance.
  Commands include `as01`, `ld01`, `ar01`, `objdump01`, `objcopy01`, `nm01`,
  `size01`, `plmc`, `srec2flex` and `plm09-sim6809`. An existing unrelated
  `sim6809` command is preserved. Previous source trees are retained as backups.
- Reusable build helpers are in `~/source/make-mc6801-tools.sh` and
  `~/source/make-plm09.sh`; use `--help` for separate staging/prefix options.
- The earlier TNFS fix is skipped when already complete. New fixes arrive via
  the update menu; the original RC6 SD archive remains unchanged.

## 2026110508 — Community Edition 2026.11 RC6 — 2026-11-05

- Updated native build scripts for stable ugBASIC1.18.1, ToolShed2.6.1,
  CMOC0.1.100 and QB64pe4.7.0-GLFW, with separate build workspaces.
- Official Linux ARM64 BASIC-To-6809 prebuilt installation, matching libraries,
  native IDE selection and maintained system assembler/disk helpers.
- This menu update refreshes build scripts; it does not automatically rebuild
  installed compilers. The RC6 SD image includes the native tool versions above
  and BASIC-To-6809 5.50. Image availability is shown on coco-pi.net.
- Numbered TNFS fix remains recognized when already bundled or installed.

## 2026110507 — Community Edition 2026.11 RC5 — 2026-11-05

- Dedicated CoCo-Pi update channel and stable installed menu entry points.
- TNFS v26.1015.1 with a pinned native Linux build, clear startup errors and
  reliable Start/Status/Stop controls. Read-only sharing remains the default.
- Release change lists, numbered fix reporting, completed-update journal and
  versioned runtime rollback archives. Matching releases leave local edits alone.
- Existing MAME0.289, XRoar1.12.1 and XRoar-AI packages remain selected.

Image availability and Raspberry Pi OS version details are listed on coco-pi.net.

## Earlier community updates — 2026-11-05

2026110504 installed the missing TNFS daemon and refreshed its build recipe.
2026110505 fixed process control after a rebuild and rejected malformed process
records. 2026110506 is the migration update from the former Installer channel.
