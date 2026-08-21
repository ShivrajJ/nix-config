{ config, pkgs, ... }:

{
  home.username = "shivraj";
  home.homeDirectory = "/home/shivraj";
  home.stateVersion = "24.05";

  # Enable desktop integration on non-NixOS Linux (exposes .desktop files to launchers)
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mimeApps.enable = true;

  xdg.desktopEntries.zellij = {
    name = "Zellij";
    genericName = "Terminal Workspace";
    comment = "A terminal multiplexer and workspace with batteries included";
    exec = "ghostty -e zellij attach --create main";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "System" "Utility" "Development" ];
    actions = {
      "new-session" = {
        name = "New Session";
        exec = "ghostty -e zellij";
      };
    };
  };

  # Enable Syncthing background user service
  services.syncthing.enable = true;

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
    "ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/ghostty";
    "zellij".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/zellij";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/btop";
    "cava".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/cava";
    "wpg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/wpg";
    "wal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/wal";
    "easyeffects".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/easyeffects";
    "noctalia".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-config/config/noctalia";
  };

  programs.home-manager.enable = true;
}
