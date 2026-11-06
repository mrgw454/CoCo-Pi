# CoCo-Pi updates

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
