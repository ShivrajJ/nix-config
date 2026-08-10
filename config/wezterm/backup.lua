local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Window Settings --
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_cols = 120
config.initial_rows = 28

-- Font Settings --
config.font_size = 10

-- Color Settings --
config.color_scheme = "carbonfox"
-- config.colors = require("themes.cyberdream")
config.window_background_opacity = 0.6

-- Miscellaneous Settings --
config.max_fps = 120
config.prefer_egl = true

return config
