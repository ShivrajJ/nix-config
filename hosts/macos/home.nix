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

  # Link root home directory dotfiles (~/.p10k.zsh, ~/.zshrc, ~/.zshenv, etc.)
  home.file = {
    ".p10k.zsh".source = ../../home_files/p10k.zsh;
    ".zshrc".source = ../../home_files/zshrc;
    ".zshenv".source = ../../home_files/zshenv;
    ".bashrc".source = ../../home_files/bashrc;
    ".gitconfig".source = ../../home_files/gitconfig;
  };

  # Symlink shared raw configuration folders to ~/.config/ on macOS
  xdg.configFile = {
    "nvim".source = ../../config/nvim;
    "kitty".source = ../../config/kitty;
    "wezterm".source = ../../config/wezterm;
    "btop".source = ../../config/btop;
  };

  programs.home-manager.enable = true;
}
