{ config, pkgs, ... }:

let
  repo = "${config.home.homeDirectory}/.config/nix-config";

  # Live, writable link into the checked-out repo (edits apply immediately).
  live = path: config.lib.file.mkOutOfStoreSymlink "${repo}/${path}";
in
{
  home.username = "shivraj";
  home.homeDirectory = "/home/shivraj";
  home.stateVersion = "24.05";

  # Enable desktop integration on non-NixOS Linux (exposes .desktop files to launchers).
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mimeApps.enable = false;

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    TERMINAL = "ghostty";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.desktopEntries.zellij = {
    name = "Zellij";
    genericName = "Terminal Workspace";
    comment = "A terminal multiplexer and workspace with batteries included";
    exec = "${pkgs.ghostty}/bin/ghostty -e ${pkgs.zellij}/bin/zellij attach --create main";
    icon = "utilities-terminal";
    terminal = false;
    categories = [
      "System"
      "Utility"
      "Development"
    ];
    actions."new-session" = {
      name = "New Session";
      exec = "${pkgs.ghostty}/bin/ghostty -e ${pkgs.zellij}/bin/zellij";
    };
  };

  # Enable Syncthing background user service.
  services.syncthing.enable = true;

  imports = [
    ../modules/common.nix
    ../modules/dev.nix
    ../modules/linux.nix
    ../modules/claude.nix
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

  # Live, writable links to the repo's config directories.
  xdg.configFile = {
    "nvim".source = live "config/nvim";
    "hypr".source = live "config/hypr";
    "kitty".source = live "config/kitty";
    "ghostty".source = live "config/ghostty";
    "zellij".source = live "config/zellij";
    "btop".source = live "config/btop";
    "cava".source = live "config/cava";
    "easyeffects".source = live "config/easyeffects";
    "noctalia".source = live "config/noctalia";
    "fastfetch".source = live "config/fastfetch";
    "zsh/plugins".source = live "config/zsh/plugins";
    "zsh/completions".source = live "config/zsh/completions";
  };

  programs.home-manager.enable = true;
}
