# cachyos

Desktop machine (`5800xMain`, AMD Ryzen 7 5800X, Radeon RX 6800 XT), running
CachyOS with Hyprland via `hyprland-uwsm`, on CachyOS's native
[noctalia](https://github.com/noctalia-dev/noctalia-shell) Quickshell-based
shell — not the JaKooLit/waybar/rofi/ags/swaync stack used in `../debian/`.

That stack is treated as **inspiration only** here, not a drop-in: this
machine's Hyprland config is Lua-based (`hyprland.lua` → `require("config.*")`
modules using an `hl` API), a different format from `debian/`'s native
`hyprland.conf`. Only pieces that are genuinely portable — same app, same
config format — get symlinked in; everything else (waybar, rofi, ags,
swaync, wlogout, nwg-displays, wallust, the JaKooLit scripts) stays behind in
`debian/` as reference for colors/keybind ideas, not as files to install.

## What's here

| Path | What it does |
|---|---|
| `config/hypr/monitors.lua` | Explicit 3-monitor portrait layout (Acer 4K primary, Lenovo + LG rotated to portrait, flanking it). Ported from `debian/config/hypr/monitors.conf`'s geometry values — same physical monitors, matched by EDID `desc:` string. |
| `config/hypr/variables.lua` | `MONITOR1/2/3` output identifiers the above reads from. |
| `config/kitty/kitty.conf` | Font/opacity/padding/scrollback/behavior settings ported from `debian/config/kitty/kitty.conf`. Keeps `include themes/noctalia.conf` — colors stay wired to the live noctalia theme instead of a static theme. |
| `config/kitty/kitty-themes/` | Full theme pack from the old setup, available as alternate options (not the active theme). |
| `config/btop/themes/`, `config/qt5ct/colors/`, `config/qt6ct/colors/` | Catppuccin theme/color options ported over as extras. Active theming for these apps is still noctalia's live-generated file in the same directory — these are just additional choices sitting alongside it. |
| `home/.gitconfig` | Same git identity as the old machine. |
| `packages/pacman.md` | Curated log of explicitly-installed software (the pacman equivalent of `../windows/packages/winget-export.json`), plus a pacman safety cheatsheet. |

## Not ported

- Keybinds — decided to relearn/remap fresh rather than port 1:1.
- Waybar/rofi/ags/swaync/wlogout/nwg-displays/wallust — noctalia replaces this whole stack natively.
- Shell dotfiles — this machine uses fish (`~/.config/fish`), not zsh. The
  distro's `cachyos-fish-config` already covers most of what the old
  `.zshrc` did (fastfetch greeting, PATH setup); only the `lsd`-based
  `ls`/`l`/`la`/`lla`/`lt` aliases were worth porting, added directly to
  `~/.config/fish/config.fish` (not repo-tracked here yet).

## Installing on a fresh CachyOS setup

```bash
./install.sh
```

Symlinks the files above into place (backing up anything already there to
`~/.dotfiles-backup-<timestamp>/`), then copies the extra theme/color files
into the btop/qt5ct/qt6ct directories alongside noctalia's live-generated
ones. See the comment at the top of `install.sh` for why those three are
copied rather than symlinked.
