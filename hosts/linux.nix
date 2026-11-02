{
  config,
  lib,
  pkgs,
  ...
}:

let
  repo = "${config.home.homeDirectory}/.config/nix-config";

  # Live, writable link into the checked-out repo (edits apply immediately).
  live = path: config.lib.file.mkOutOfStoreSymlink "${repo}/${path}";
in
{
  home.username = "shivraj";
  home.homeDirectory = "/home/shivraj";
  home.stateVersion = "26.11";

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
    "kitty".source = live "config/kitty";
    "ghostty".source = live "config/ghostty";
    "zellij".source = live "config/zellij";
    "cava".source = live "config/cava";
    "easyeffects".source = live "config/easyeffects";
    "fastfetch".source = live "config/fastfetch";
    "zsh/plugins".source = live "config/zsh/plugins";
    "zsh/completions".source = live "config/zsh/completions";
  };

  # Hyprland, Noctalia, and btop write into their config directories, so they
  # must not be live links into the repo. Static Hyprland files are refreshed
  # on every activation; generated/user-owned files are seeded once.
  home.activation.seedWritableConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    set -eu

    if [ -L "$HOME/.config/hypr" ]; then
      rm "$HOME/.config/hypr"
    fi
    mkdir -p "$HOME/.config/hypr/scripts"
    cp -f ${../config/hypr/hyprland.lua} "$HOME/.config/hypr/hyprland.lua"
    cp -f ${../config/hypr/noctalia_hyprland.lua} "$HOME/.config/hypr/noctalia_hyprland.lua"
    cp -f ${../config/hypr/scripts/dynamic-borders.sh} "$HOME/.config/hypr/scripts/dynamic-borders.sh"
    chmod +x "$HOME/.config/hypr/scripts/dynamic-borders.sh"
    if [ ! -e "$HOME/.config/hypr/noctalia.lua" ]; then
      cp -f ${../config/hypr/noctalia.lua} "$HOME/.config/hypr/noctalia.lua"
    fi

    if [ -L "$HOME/.config/noctalia" ]; then
      rm "$HOME/.config/noctalia"
    fi
    mkdir -p "$HOME/.config/noctalia"
    if [ ! -e "$HOME/.config/noctalia/config.toml" ]; then
      cp -f ${../config/noctalia/config.toml} "$HOME/.config/noctalia/config.toml"
    fi

    if [ -L "$HOME/.config/btop" ]; then
      rm "$HOME/.config/btop"
    fi
    mkdir -p "$HOME/.config/btop"
    if [ ! -e "$HOME/.config/btop/btop.conf" ]; then
      cp -f ${../config/btop/btop.conf} "$HOME/.config/btop/btop.conf"
    fi
  '';

  programs.home-manager.enable = true;
}
