{ pkgs, ... }:

{
  # Packages shared across all Linux hosts.
  home.packages = with pkgs; [
    noctalia
    mpvpaper # used by Noctalia's mpvpaper plugin
    playerctl # media-key fallback
    brightnessctl # brightness-key fallback
    socat # used by config/hypr/scripts/dynamic-borders.sh
  ];
}
