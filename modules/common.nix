{ pkgs, inputs, ... }:

let
  weztermPkg = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # On Linux (non-NixOS), wrap wezterm so it can access host OpenGL/EGL/Vulkan drivers in /usr/lib
  wezterm = if pkgs.stdenv.isLinux then
    pkgs.symlinkJoin {
      name = "wezterm-wrapped";
      paths = [ weztermPkg ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        for bin in $out/bin/*; do
          if [ -x "$bin" ]; then
            wrapProgram "$bin" --prefix LD_LIBRARY_PATH : "/usr/lib:/usr/lib32"
          fi
        done
      '';
    }
  else
    weztermPkg;
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
