{ pkgs, ... }:

{
  system.primaryUser = "shivraj";

  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # macOS System Defaults
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.InitialKeyRepeat = 15;
  };

  # Nix daemon managed by Determinate Nix
  nix.enable = false;

  # Primary user on macOS
  users.users.shivraj = {
    name = "shivraj";
    home = "/Users/shivraj";
  };

  # Homebrew Integration
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    taps = [
      "localstack/tap"
      "deskflow/tap"
      "pear-devs/pear"
    ];
    brews = [
      "cocoapods"
      "gcc"
      "localstack/tap/localstack-cli"
    ];
    casks = [
      "bitwarden"
      "bruno"
      "db-browser-for-sqlite"
      "deskflow/tap/deskflow"
      "font-iosevka"
      "gcloud-cli"
      "kdenlive"
      "lm-studio"
      "obsidian"
      "pear-devs/pear/pear-desktop"
      "reactotron"
      "visual-studio-code"
      "wezterm"
    ];
  };

  system.stateVersion = 4;
}
