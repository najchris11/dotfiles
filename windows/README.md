# windows

Setup reference for my Windows box, retired 2026-08 (survey done and archived same day the machine was decommissioned).

This isn't an installer — Windows config is mostly registry/binary state that doesn't symlink cleanly like the [`debian/`](../debian/README.md) setup does. This folder is a **record**: what was installed, what was customized, and where the real data (not the config) ended up. See [`RESTORE.md`](RESTORE.md) for the personal-file side of that.

## System

- **OS:** Windows 11 Pro
- **Shell:** PowerShell 5.1, with VS Code's shell integration hook loaded from `$PROFILE`
- **Package managers:** winget (primary), Chocolatey (secondary, legacy), nvm-windows for Node
- **Git:** SSH-based auth, `git-lfs` filters enabled globally

## Config → this repo

| Component | Live path | This repo |
|---|---|---|
| Git identity | `~/.gitconfig` | `config/git/.gitconfig` |
| VS Code settings | `%APPDATA%\Code\User\settings.json` | `config/vscode/settings.json` |
| VS Code extensions | `code --list-extensions` | `config/vscode/extensions.txt` |
| PowerShell profile | `$PROFILE` | `config/powershell/profile.ps1` |
| Windows Terminal | `...\Microsoft.WindowsTerminal_.../LocalState\settings.json` | `config/windows-terminal/settings.json` |
| OBS Studio | `%APPDATA%\obs-studio` | `config/obs-studio/` (scenes/profile/global.ini only — cache, logs, browser-source cookies, and the obs-websocket password were stripped before this went in a public repo) |
| Notepad++ | `%APPDATA%\Notepad++` | `config/notepad++/` |
| SSH public key + known hosts | `~/.ssh/id_ed25519.pub`, `known_hosts` | `home/.ssh/` — **the private key is deliberately not here.** It was copied out to the SSD/password manager separately; this repo is public. |
| Installed packages | `winget list` | `packages/winget-export.json` — restore with `winget import -i packages/winget-export.json` |

## Not carried over here

- **foobar2000** (`%APPDATA%\foobar2000-v2`, ~2 GB: library DB, playlists, DSP presets, Georgia Reborn theme, installed components) and **Serato** (`_Serato_` crates, ~230 MB, three near-duplicate copies) are real, heavily-used profiles but too large/binary for git. They went to the external SSD as full folder copies instead.
- **WinSCP** had 4 saved sites (incl. an FTP login for mcjeterbooks.com). Exported via WinSCP's own *Tools → Export Configuration* rather than reading the registry, since some fields are encrypted under a master password — kept off git, stored with the SSD archive.
- Everything else installed (Zoom, Spark, Picard, GitHub Desktop, PuTTY) had no real user config worth keeping — checked, genuinely empty/default.

## Reinstalling packages on a future Windows box

```powershell
winget import -i windows/packages/winget-export.json --accept-package-agreements --accept-source-agreements
```

Note a handful of entries (Notepad++, Realtek Audio Control, Mail and Calendar, etc.) aren't resolvable through winget's sources and were skipped from the export — reinstall those manually if needed.
