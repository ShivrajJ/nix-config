{ pkgs, ... }:

{
  home.username = "shivraj";
  home.homeDirectory = "/Users/shivraj";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/common.nix
    ../../modules/claude.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
