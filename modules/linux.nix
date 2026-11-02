{ pkgs, ... }:

{
  # Packages shared across all Linux hosts.
  home.packages = with pkgs; [
    noctalia
    socat # used by config/hypr/scripts/dynamic-borders.sh
  ];
}
