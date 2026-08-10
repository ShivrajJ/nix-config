local wezterm = require("wezterm")
local home = os.getenv("HOME")

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

-- Keybindings --
config.mouse_bindings = {
	-- Slower scroll up/down (3 lines instead of Page Up/Down)
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(-3),
		alt_screen = false,
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(3),
		alt_screen = false,
	},
}

-- Font Settings --
config.font_size = 12
config.font = wezterm.font("Iosevka")

-- Color Settings --
-- wezterm.add_to_config_reload_watch_list(home .. "/.cache/wal/colors-wezterm.toml")
-- config.color_scheme_dirs = { home .. "/.cache/wal" }
-- config.color_scheme = "colors-wezterm"
config.colors = require("themes.cyberdream")
-- config.window_background_opacity = 0.5

-- Miscellaneous Settings --
config.max_fps = 120
config.prefer_egl = true

return config
