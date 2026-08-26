# Packages (pacman)

Curated list of explicitly-installed, non-default software on this machine —
the pacman equivalent of `../../windows/packages/winget-export.json`. Not an
automated export (pacman doesn't have winget's clean "user-installed" concept
without noise from base/dependency packages) — just a hand-kept log so a
reinstall doesn't mean re-remembering everything from scratch.

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

```bash
sudo pacman -S lsd code prismlauncher legcord feishin cachyos-gaming-meta steam
```

## Needs an AUR helper (not yet decided)

- `android-studio` — not in the official or CachyOS repos, AUR only. No AUR
  helper (`paru`/`yay`) installed on this machine yet — that's its own
  decision (building/trusting an AUR helper) before this can be added.

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
