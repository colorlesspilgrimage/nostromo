-- Nostromo: Omarchy's generated border setup, rounded corners, CRT shader.
local active_border_color = { colors = { "rgba(ffb627ee)", "rgba(c4400fee)" }, angle = 45 }
local inactive_border_color = "rgba(4a2a08aa)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    rounding = 20,
    -- CRT scanlines/bloom/vignette over the whole screen. Remove this line to disable.
    screen_shader = os.getenv("HOME") .. "/.local/state/omarchy/current/theme/crt.frag",
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})
