-- Nostromo Day: amber-to-burnt-orange border, rounded corners, no screen shader.
local active_border_color = { colors = { "rgba(b35900ee)", "rgba(c4400fee)" }, angle = 45 }
local inactive_border_color = "rgba(8a6a4566)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    rounding = 20,
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})
