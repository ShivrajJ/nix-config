-- Hades host-specific Hyprland setup.
-- Loaded by ~/.config/hypr/hyprland.lua via ~/.config/hypr-host.lua.

-- External HDMI monitor.
-- Verify the output name on Hades with `hyprctl monitors` if it changes.
hl.monitor({
	output = "HDMI-A-2",
	mode = "3840x2160@120.00",
	position = "0x0",
	scale = 2,
})

-- Hades has two GPUs:
--   - AMD Radeon iGPU (Ryzen 7 9800X3D)
--   - AMD Radeon RX 9070 XT (dedicated)
--
-- Which one to put first depends on where the monitor is plugged in. If it is
-- connected to the RX 9070 XT (the usual desktop setup), make the dGPU primary.
-- Find the card numbers on Hades first:
--   lspci -nn | grep -Ei 'vga|3d|display'
--   ls -l /dev/dri/by-path
--   for c in /sys/class/drm/card*-*; do
--     [ -e "$c/status" ] && echo "$(basename "$c"): $(cat "$c/status")"
--   done
-- Then add (first entry = primary):
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card2")
--
-- If the monitor is connected to the motherboard HDMI/DP (iGPU), put the iGPU
-- first instead, or leave AQ_DRM_DEVICES unset and let Hyprland auto-detect.
