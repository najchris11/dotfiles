# dotfiles

Personal dotfiles, organized per machine/OS.

## Machines

| Folder | Machine / OS | Details |
|---|---|---|
| [`debian/`](debian/README.md) | Debian (sid/testing) + Hyprland | Desktop config, built on [JaKooLit's Debian-Hyprland](https://github.com/JaKooLit/Debian-Hyprland) |
| [`cachyos/`](cachyos/README.md) | CachyOS + Hyprland | `5800xMain`. Native CachyOS/noctalia desktop stack — see its README for what was ported from `debian/` vs. left as inspiration only. |
| [`windows/`](windows/README.md) | Windows 11 Pro | Retired 2026-08. Reference/archive only — see [`windows/RESTORE.md`](windows/RESTORE.md) for what's still Backblaze-dependent. |

Each folder is self-contained: its own `install.sh`, its own `.gitignore`, its own README with setup details.

## Adding a new machine

```bash
mkdir <name>
# add config/, home/, install.sh, README.md under <name>/
```
