#!/usr/bin/env bash
# Restore last wallpaper to all monitors on startup

WALLPAPER_CURRENT="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

if [[ ! -f "$WALLPAPER_CURRENT" ]]; then
  exit 0
fi

for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
  swww img -o "$monitor" "$WALLPAPER_CURRENT"
done
