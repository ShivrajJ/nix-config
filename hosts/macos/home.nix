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

  # Symlink shared raw configuration folders to ~/.config/ on macOS
  xdg.configFile = {
    "nvim".source = ../../config/nvim;
    "kitty".source = ../../config/kitty;
    "wezterm".source = ../../config/wezterm;
    "btop".source = ../../config/btop;
  };

  programs.home-manager.enable = true;
}
