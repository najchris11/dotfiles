#!/usr/bin/env bash
# Dotfiles install script
# Symlinks configs from this repo to their live locations.
# Backs up any existing files/dirs before overwriting.

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

echo "==> Installing dotfiles from $DOTFILES"
echo "==> Backups (if any) will go to $BACKUP_DIR"
echo ""

# Home dotfiles
echo "[home]"
backup_and_link "$DOTFILES/home/.zshrc"     "$HOME/.zshrc"
backup_and_link "$DOTFILES/home/.zshenv"    "$HOME/.zshenv"
backup_and_link "$DOTFILES/home/.zprofile"  "$HOME/.zprofile"
backup_and_link "$DOTFILES/home/.gitconfig" "$HOME/.gitconfig"

echo ""
echo "[config]"
for dir in hypr waybar rofi ags swaync kitty ghostty fastfetch btop wallust wlogout qt5ct qt6ct Kvantum cava swappy wezterm; do
    backup_and_link "$DOTFILES/config/$dir" "$HOME/.config/$dir"
done

echo ""
echo "Done! If anything was backed up, find it in: $BACKUP_DIR"
