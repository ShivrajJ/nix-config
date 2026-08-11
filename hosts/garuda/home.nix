{ config, pkgs, ... }:

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

  # Live Writable Symlinks directly to ~/.config/nix-config/config/
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/nvim";
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/hypr";
    "hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/hyprpanel";
    "walker".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/walker";
    "mako".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/mako";
    "kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/kitty";
    "wezterm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/wezterm";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/btop";
    "cava".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/cava";
    "wpg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/wpg";
    "wal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/wal";
    "easyeffects".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/easyeffects";
  };

  programs.home-manager.enable = true;
}
