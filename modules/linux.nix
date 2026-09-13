{ pkgs, ... }:

{
  # Packages shared across all Linux hosts
  home.packages = with pkgs; [
    noctalia
  ];
}
