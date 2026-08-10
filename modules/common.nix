{ pkgs, ... }:

{
  # Core Packages shared across Linux & macOS
  home.packages = with pkgs; [
    # CLI Utilities
    git
    gh
    direnv
    nix-direnv
    fzf
    btop
    fastfetch
    ripgrep
    fd
    jq
    tree
    micro

    # Developer Runtimes / Tools
    nodejs
    python3
    go
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
