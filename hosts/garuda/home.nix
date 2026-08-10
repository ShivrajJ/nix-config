{ pkgs, ... }:

{
  home.username = "shivraj";
  home.homeDirectory = "/home/shivraj";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/common.nix
    ../../modules/claude.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Link root home directory dotfiles (~/.p10k.zsh, ~/.zshrc, ~/.zshenv, etc.)
  home.file = {
    ".p10k.zsh".source = ../../home_files/p10k.zsh;
    ".zshrc".source = ../../home_files/zshrc;
    ".zshenv".source = ../../home_files/zshenv;
    ".bashrc".source = ../../home_files/bashrc;
    ".gitconfig".source = ../../home_files/gitconfig;
  };

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

  programs.home-manager.enable = true;
}
