# Nostromo

An amber CRT terminal theme for [Omarchy](https://omarchy.org/), inspired by the
Weyland-Yutani hardware aboard the USCSS Nostromo: warm black, amber phosphor
text, red for alerts, rounded windows, and full-screen scanlines.

![Nostromo on Omarchy](docs/screenshot.png)

## What's in it

| File | What it does |
|---|---|
| `colors.toml` | Palette. Amber text on warm black, Weyland-Yutani red for alerts. Omarchy generates terminal, btop, bar and other app themes from it. |
| `hyprland.lua` | Amber-to-burnt-orange window border, 20px rounded corners, and the CRT shader. |
| `crt.frag` | Full-screen Hyprland shader: scanlines, soft phosphor bloom, vignette. |
| `shell.toml` | Bar and popup styling. |
| `chromium.theme` | Warm-black frame color for Chromium, Chrome, Edge and Brave. |
| `icons.theme` | `Yaru-yellow-dark` icon theme. |
| `backgrounds/` | A generated amber MU-TH-UR terminal wallpaper. |

## Install

Requires Omarchy with Hyprland 0.55+ (Lua config).

```bash
git clone https://github.com/colorlesspilgrimage/nostromo.git
cd nostromo
./install.sh
```

The script:

1. copies the theme to `~/.config/omarchy/themes/nostromo/`,
2. installs the `ttf-iosevka-nerd` package if Iosevka Nerd Font Mono is missing,
3. runs `omarchy font set "Iosevka Nerd Font Mono"`,
4. runs `omarchy theme set nostromo`.

Options: `--no-font` keeps your current system font (the font package is still installed), and `--no-apply` installs
the files without switching themes.

### Don't use `omarchy theme install <url>`

Omarchy deliberately drops `*.lua` files from themes installed from a git URL,
because they run code. That removes `hyprland.lua`, so you would lose the rounded
corners and the scanline shader. `./install.sh` copies the theme as a
hand-written local theme, which Omarchy does not restrict.

## After installing

**Font size.** Terminals and the bar use Omarchy's default sizes (9 and a base size of
12). To enlarge the bar text, change `base-size` in `shell.toml`, run
`./install.sh --no-font`, then `omarchy restart shell`. For terminals, edit the size in
your terminal's config and run `omarchy restart terminal`. Note that `omarchy font set`
resets terminal sizes to 9.

**Wallpaper.** Cycle backgrounds with `omarchy theme bg next`. Put your own images
in `backgrounds/` before installing, or in `~/.config/omarchy/backgrounds/nostromo/`.

## Customizing

- **Turn off the scanlines.** Remove the `screen_shader` line from `hyprland.lua`
  and reinstall. Note that the shader also appears in screenshots and recordings,
  and Hyprland cannot skip compositing for fullscreen apps while it is active.
- **Tune the CRT effect.** In `crt.frag`, `0.12` is bloom strength, `0.88` is
  scanline darkness and `0.45` is vignette strength.
- **Corner radius.** Change `rounding = 20` in `hyprland.lua`.
- **Colors.** `shell.toml` is a copy of what Omarchy generates from
  `colors.toml`, with the font size changed. If you edit colors in `colors.toml`,
  update the matching colors in `shell.toml` too, or delete `shell.toml` to let
  Omarchy generate it.

After any edit, run `./install.sh --no-font` to re-apply.

## Uninstall

```bash
omarchy theme set <another-theme>
rm -rf ~/.config/omarchy/themes/nostromo
omarchy font set <your-previous-font>
```

## Credits and licenses

- **Font:** [Iosevka](https://github.com/be5invis/Iosevka) (SIL OFL 1.1), patched by
  [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts). It is installed from the
  `ttf-iosevka-nerd` package and not bundled in this repo.
- **Theme files, shader, wallpaper and installer:** MIT, see `LICENSE`. The font is
  not covered by it and keeps its own license.
- Weyland-Yutani, Nostromo and MU-TH-UR belong to their respective owners (the
  *Alien* franchise). This is a fan theme and is not affiliated with them.
