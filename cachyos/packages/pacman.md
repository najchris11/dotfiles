# Packages (pacman)

`shelly` (already installed on this machine — `cachyos/shelly`, a unified
Arch/AUR/Flatpak/AppImage package manager, GUI at `shelly-ui`) has its own
export/import built in and is the real source of truth going forward:

```bash
shelly backup --export -a pacman -d packages/     # writes packages/pacman.toml
shelly backup --import -a pacman -d packages/     # reinstalls everything from it, on a fresh box
```

Regenerate `pacman.toml` after installing anything on purpose and commit it —
that's the actual machine-readable equivalent of
`../../windows/packages/winget-export.json`. The table below is a hand-kept
snapshot from before `shelly` was in the loop; keep it updated too since it's
more skimmable, but `pacman.toml` (once exported) is authoritative.

`shelly` also removes the "needs an AUR helper" decision entirely —
`shelly install aur <pkg>` handles AUR packages the same as
`shelly install standard <pkg>` handles repo ones, no separate paru/yay setup.

## Installed

| Package | Repo | What it is |
|---|---|---|
| `lsd` | cachyos-extra | Modern `ls` replacement — aliased in `../config/fish/config.fish` |
| `code` | cachyos-extra | VS Code |
| `prismlauncher` | cachyos-extra | Minecraft launcher (replaces `PrismLauncher.PrismLauncher` from the Windows winget list) |
| `legcord` | cachyos | Discord client |
| `feishin` | extra | Music client |
| `cachyos-gaming-meta` | cachyos | Proton-CachyOS/Wine-CachyOS/Vulkan gaming dependency bundle |
| `steam` | multilib | Steam (not pulled in by `cachyos-gaming-meta` itself, installed alongside it) |
| `android-studio` | AUR | Via `shelly install aur`, no separate AUR helper needed |

```bash
shelly install standard code prismlauncher legcord feishin cachyos-gaming-meta steam
shelly install aur android-studio
```

Android Studio itself is managed through **JetBrains Toolbox**
(jetbrains.com/toolbox — official self-contained download, no package
manager) rather than the bare `android-studio` package, so Toolbox handles
IDE updates. `shelly install aur android-studio` above is the fallback if
Toolbox isn't wanted.

## Keeping this list honest

After installing something new on purpose, add a row above. To check what's
explicitly installed vs. pulled in as a dependency (useful when this file
drifts from reality):

```bash
pacman -Qqe   # everything explicitly installed
pacman -Qqd   # everything installed only as a dependency
```

## pacman cheatsheet — stay updated without nuking the system

| Command | What it does |
|---|---|
| `sudo pacman -Syu` | Full system upgrade. **Always do a full `-Syu`, never a partial upgrade** (`-Sy` alone, or `-S <pkg>` right after `-Sy` without also `-u`) — partial upgrades are the #1 way to break an Arch-based system, since it can pull in a package built against newer libs than what's currently on disk. |
| `sudo pacman -Syu <pkg>` | Fine — this is a full upgrade that also (re)installs `<pkg>`, not a partial one. |
| `pacman -Qu` | List what's outdated without installing, if you just want to check. |
| `pacman -Qi <pkg>` | Info on an installed package (version, deps, install reason). |
| `pacman -Qo <file>` | Which package owns a given file — handy when something breaks and you don't know what put it there. |
| `pacman -Rns <pkg>` | Remove a package **and** its now-unneeded dependencies **and** its config files. The one to reach for when actually uninstalling something. |
| `pacman -R <pkg>` | Remove just the package, leaves orphaned deps and config files behind — usually not what you want. |
| `pacman -Qdt` | List orphaned packages (installed as a dependency, nothing depends on them anymore) — safe to review and `pacman -Rns` them to clean up. |
| `sudo pacman -Sc` | Clear the package cache down to the current + previous version of each package. Safe. |
| `sudo pacman -Scc` | Clear the *entire* package cache, including current versions — means no rollback path via `pacman -U` if an update breaks something. Only run this if you're tight on disk space and understand you're giving that up. |
| `pactree <pkg>` | Show why something is installed / what it depends on (needs `pacman-contrib`). |

The one habit worth keeping: never split `-Sy` (sync database) from `-u`
(upgrade) across separate commands or a delay. If you're not doing a full
`-Syu` right now, don't run `-Sy` at all.
