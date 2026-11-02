{ pkgs, ... }:

{
  # Developer runtimes, build tools, and cloud CLIs.
  # Import only on hosts that need them.
  home.packages = with pkgs; [
    # Cloud & DevOps Tools
    awscli2
    google-cloud-sdk
    kubernetes-helm
    opentofu

    # Developer Runtimes & Build Tools
    nodejs
    uv
    python311
    go
    maven
    gradle
    google-java-format
    ocaml
    opam
  ];
}
