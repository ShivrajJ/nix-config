{ pkgs, ... }:

{
  # macOS System Defaults
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
  };

  # Enable Flakes on macOS
  nix.settings.experimental-features = "nix-command flakes";

  # Primary user on macOS
  users.users.shivraj = {
    name = "shivraj";
    home = "/Users/shivraj";
  };
}
