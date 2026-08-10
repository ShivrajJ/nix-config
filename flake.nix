{
  description = "Cross-Platform Nix Dotfiles (Garuda Linux & macOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }: {
    # 1. Garuda Linux Setup (Standalone Home Manager)
    homeConfigurations."shivraj@garuda" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [ ./hosts/garuda/home.nix ];
    };

    # 2. macOS Setup (nix-darwin + Home Manager)
    darwinConfigurations."Shivrajs-MacBook-Air" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/macos/darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.shivraj = import ./hosts/macos/home.nix;
        }
      ];
    };

    darwinConfigurations."macbook" = self.darwinConfigurations."Shivrajs-MacBook-Air";
  };
}
