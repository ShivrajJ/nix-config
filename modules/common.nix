{ pkgs, inputs, ... }:

let
  wezterm = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  # Core Packages shared across Linux & macOS
  home.packages = with pkgs; [
    # CLI Utilities & Tools
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
    neovim
    shellcheck
    shfmt
    syncthing
    watchman

    # Applications & Tools
    obsidian
    wezterm
    ghostty

    # Cloud & DevOps Tools
    awscli2
    google-cloud-sdk
    kubernetes-helm
    opentofu

    # Developer Runtimes & Build Tools
    gcc
    nodejs
    python3
    go
    maven
    gradle
    google-java-format
    ocaml
    opam
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
