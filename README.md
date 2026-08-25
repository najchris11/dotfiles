# dotfiles

Personal dotfiles, organized per machine/OS.

## Machines

| Folder | Machine / OS | Details |
|---|---|---|
| [`debian/`](debian/README.md) | Debian (sid/testing) + Hyprland | Desktop config, built on [JaKooLit's Debian-Hyprland](https://github.com/JaKooLit/Debian-Hyprland) |

Each folder is self-contained: its own `install.sh`, its own `.gitignore`, its own README with setup details.

## Adding a new machine

```bash
mkdir <name>
# add config/, home/, install.sh, README.md under <name>/
```
