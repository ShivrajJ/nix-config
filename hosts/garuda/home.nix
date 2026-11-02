{ ... }:

{
  imports = [ ../linux.nix ];

  # Host-specific Hyprland overrides (monitors, GPU env, input devices).
  xdg.configFile."hypr-host.lua".source = ./hypr-host.lua;
}
