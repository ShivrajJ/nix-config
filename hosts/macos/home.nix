{ config, pkgs, ... }:

let
  repo = "${config.home.homeDirectory}/.config/nix-config";

  # Live, writable link into the checked-out repo (edits apply immediately).
  live = path: config.lib.file.mkOutOfStoreSymlink "${repo}/${path}";
in
{
  home.username = "shivraj";
  home.homeDirectory = "/Users/shivraj";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    TERMINAL = "ghostty";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Syncthing is a background service on Linux; macOS only needs the binary.
  home.packages = [ pkgs.syncthing ];

  imports = [
    ../../modules/common.nix
    ../../modules/dev.nix
    ../../modules/claude.nix
  ];

  # Root dotfiles are live links so they stay editable.
  home.file = {
    ".p10k.zsh".source = live "home_files/p10k.zsh";
    ".zshrc".source = live "home_files/zshrc";
    ".zshenv".source = live "home_files/zshenv";
    ".bashrc".source = live "home_files/bashrc";
    ".bash_profile".source = live "home_files/bash_profile";
    ".gitconfig".source = live "home_files/gitconfig";
  };

  # Live, writable links to the repo's shared config directories.
  xdg.configFile = {
    "nvim".source = live "config/nvim";
    "kitty".source = live "config/kitty";
    "ghostty".source = live "config/ghostty";
    "zellij".source = live "config/zellij";
    "btop".source = live "config/btop";
    "zsh".source = live "config/zsh";
    "fastfetch".source = live "config/fastfetch";
  };

  programs.home-manager.enable = true;
}
