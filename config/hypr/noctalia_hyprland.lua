-- Noctalia Shell Hyprland Configuration
-- Sourced by ~/.config/hypr/hyprland.lua

-- 1. Autostart Noctalia daemon
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
end)

-- 2. Core Binds & Media Keys
local mainMod = "SUPER"
local ipc = "noctalia msg "

-- Try Noctalia first; fall back to the native tools if the shell is not ready.
local function with_fallback(primary, backup)
	return primary .. " 2>/dev/null || " .. backup
end

-- Core Binds
hl.bind("ALT + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))

-- Media & Brightness Keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(with_fallback(ipc .. "volume-up", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")),
	{ locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(with_fallback(ipc .. "volume-down", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")),
	{ locked = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(with_fallback(ipc .. "volume-mute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),
	{ locked = true }
)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
	locked = true,
})
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(with_fallback(ipc .. "brightness-up", "brightnessctl set 5%+")),
	{ locked = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(with_fallback(ipc .. "brightness-down", "brightnessctl set 5%-")),
	{ locked = true }
)

-- Media transport keys (Noctalia does not handle these; playerctl does).
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- 3. Window Rules
hl.window_rule({
	name = "noctalia_settings",
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- 4. Dynamic theme colors are applied at the end of hyprland.lua.
