#!/bin/bash
# Install the Nostromo theme for Omarchy: theme files, bundled font, and apply.
#
#   ./install.sh               install theme + font, set the font, apply the theme
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
font_dir="$HOME/.local/share/fonts"

# Theme: only the files Omarchy needs (not the README, fonts, or docs).
rm -rf "$theme_dir"
mkdir -p "$theme_dir"
cp -r "$src"/{colors.toml,crt.frag,hyprland.lua,shell.toml,chromium.theme,icons.theme,preview.png,backgrounds} "$theme_dir"/
echo "Installed theme to $theme_dir"

# Font: 3270 Nerd Font Mono, per-user.
mkdir -p "$font_dir"
cp "$src"/fonts/*.ttf "$font_dir"/
fc-cache -f "$font_dir"
echo "Installed font to $font_dir"

if $set_font; then
  omarchy font set "3270 Nerd Font Mono"
  echo "Set system font. Terminal font sizes reset; see the README to set them."
fi

if $apply; then
  omarchy theme set nostromo
fi
