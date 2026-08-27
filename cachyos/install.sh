#!/usr/bin/env bash
# Dotfiles install script for the CachyOS + Hyprland (noctalia) machine.
# Symlinks configs from this repo to their live locations.
# Backs up any existing files/dirs before overwriting.
#
# Note: unlike debian/install.sh, this does NOT symlink whole ~/.config/<app>
# directories for kitty/btop/qt5ct/qt6ct. Those directories also hold files
# that noctalia generates live to keep app theming in sync with the desktop
# theme (kitty/themes/noctalia.conf, btop/themes/noctalia.theme,
# qt5ct|qt6ct/colors/noctalia.conf). Symlinking the whole directory would
# fight with that. So: symlink only the files this repo actually owns, and
# copy (not symlink) the extra theme packs into the shared theme dirs.

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

backup_and_link() {
    local src="$1"   # path in this repo
    local dest="$2"  # target path on the system

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  Backing up $dest → $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "  Linked $src → $dest"
}

copy_extra() {
    local src="$1"
    local destdir="$2"
    mkdir -p "$destdir"
    cp -n "$src" "$destdir/"
    echo "  Copied $src → $destdir/"
}

echo "==> Installing dotfiles from $DOTFILES"
echo "==> Backups (if any) will go to $BACKUP_DIR"
echo ""

# Home dotfiles
echo "[home]"
backup_and_link "$DOTFILES/home/.gitconfig" "$HOME/.gitconfig"

echo ""
echo "[config - symlinked]"
backup_and_link "$DOTFILES/config/hypr/monitors.lua"  "$HOME/.config/hypr/config/monitors.lua"
backup_and_link "$DOTFILES/config/hypr/variables.lua" "$HOME/.config/hypr/config/variables.lua"
backup_and_link "$DOTFILES/config/hypr/windowrules.lua" "$HOME/.config/hypr/config/windowrules.lua"
backup_and_link "$DOTFILES/config/kitty/kitty.conf"    "$HOME/.config/kitty/kitty.conf"
backup_and_link "$DOTFILES/config/kitty/kitty-themes"  "$HOME/.config/kitty/kitty-themes"
backup_and_link "$DOTFILES/config/fish/config.fish"    "$HOME/.config/fish/config.fish"

echo ""
echo "[config - copied extras, alongside noctalia's live theme files]"
for f in "$DOTFILES"/config/btop/themes/*.theme; do
    copy_extra "$f" "$HOME/.config/btop/themes"
done
for f in "$DOTFILES"/config/qt5ct/colors/*.conf; do
    copy_extra "$f" "$HOME/.config/qt5ct/colors"
done
for f in "$DOTFILES"/config/qt6ct/colors/*.conf; do
    copy_extra "$f" "$HOME/.config/qt6ct/colors"
done

echo ""
echo "Done! If anything was backed up, find it in: $BACKUP_DIR"
