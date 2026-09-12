{ pkgs, inputs, ... }:

let
  ghostty = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
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
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    ghostty
    noctalia
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
