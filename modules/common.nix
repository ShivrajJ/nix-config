{ pkgs, ... }:

let
  ghostty = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
in
{
  # Core CLI and GUI packages shared across Linux & macOS.
  home.packages = with pkgs; [
    # CLI Utilities & Tools
    git
    gh
    direnv
    nix-direnv
    fzf
    btop
    fastfetch
    chafa
    ripgrep
    fd
    jq
    tree
    micro
    neovim
    shellcheck
    shfmt
    syncthing
    watchman
    zellij

    # Applications & Tools
    obsidian
    ghostty
  ];

  # Direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Git Configuration
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
