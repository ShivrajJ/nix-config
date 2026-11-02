-- Garuda host-specific Hyprland setup.
-- Loaded by ~/.config/hypr/hyprland.lua via ~/.config/hypr-host.lua.

-- Internal laptop panel (eDP-1 is wired to the AMD iGPU, card2).
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@120.03",
	position = "0x0",
	scale = 1,
})

-- This laptop has two GPUs:
--   card1 = NVIDIA GTX 1650 (dGPU, HDMI-A-1)
--   card2 = AMD Radeon Vega (iGPU, boot VGA, drives eDP-1)
-- Put AMD first so the compositor uses the GPU that owns the internal panel,
-- with NVIDIA available as the secondary/offload device.
hl.env("AQ_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")

-- NVIDIA is the dGPU. These only matter for clients that explicitly render on
-- NVIDIA; the compositor itself scans out through the AMD iGPU.
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Toolkit scaling for the 1080p internal panel.
-- GDK_SCALE must be an integer; GDK_DPI_SCALE carries the fractional part.
hl.env("GDK_SCALE", 1)
hl.env("GDK_DPI_SCALE", 1.25)
hl.env("QT_SCALE_FACTOR", 1.25)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("STEAM_FORCE_DESKTOPUI_SCALING", 1.25)
