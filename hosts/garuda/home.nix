{ pkgs, ... }:

{
  home.username = "shivraj";
  home.homeDirectory = "/home/shivraj";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/common.nix
    ../../modules/claude.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Symlink raw dotfile configuration folders to ~/.config/
  xdg.configFile = {
    "nvim".source = ../../config/nvim;
    "hypr".source = ../../config/hypr;
    "hyprpanel".source = ../../config/hyprpanel;
    "walker".source = ../../config/walker;
    "mako".source = ../../config/mako;
    "kitty".source = ../../config/kitty;
    "wezterm".source = ../../config/wezterm;
    "btop".source = ../../config/btop;
    "cava".source = ../../config/cava;
    "wpg".source = ../../config/wpg;
    "wal".source = ../../config/wal;
    "easyeffects".source = ../../config/easyeffects;
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
