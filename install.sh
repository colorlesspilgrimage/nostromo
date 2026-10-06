#!/bin/bash
# Install the Nostromo theme for Omarchy: theme files, font package, and apply.
#
#   ./install.sh               install themes (nostromo, nostromo-day) + font, set the font, apply nostromo
#   ./install.sh --no-font     install the font but keep your current system font
#   ./install.sh --no-apply    install files only
set -euo pipefail

set_font=true
apply=true
for arg in "$@"; do
  case "$arg" in
    --no-font) set_font=false ;;
    --no-apply) apply=false ;;
    -h|--help) sed -n '2,7p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

command -v omarchy >/dev/null || { echo "omarchy not found on PATH" >&2; exit 1; }

src="$(cd "$(dirname "$0")" && pwd)"
theme_dir="$HOME/.config/omarchy/themes/nostromo"

# Theme: only the files Omarchy needs (not the README or docs).
rm -rf "$theme_dir"
mkdir -p "$theme_dir"
cp -r "$src"/{colors.toml,crt.frag,hyprland.lua,shell.toml,chromium.theme,icons.theme,preview.png,backgrounds} "$theme_dir"/
echo "Installed theme to $theme_dir"

# Daylight variant, installed as its own theme: nostromo-day.
day_dir="$HOME/.config/omarchy/themes/nostromo-day"
rm -rf "$day_dir"
mkdir -p "$day_dir"
cp -r "$src"/day/* "$day_dir"/
echo "Installed daylight theme to $day_dir"

# Font: Iosevka Nerd Font Mono, from the Arch package.
if ! fc-list | grep -Fqi "Iosevka Nerd Font Mono"; then
  omarchy-pkg-add ttf-iosevka-nerd
  fc-cache -f
fi

if $set_font; then
  omarchy font set "Iosevka Nerd Font Mono"
  echo "Set system font. Terminal font sizes reset; see the README to set them."
fi

if $apply; then
  omarchy theme set nostromo
fi
