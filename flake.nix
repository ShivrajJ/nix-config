{
  description = "Cross-Platform Nix Dotfiles (Garuda Linux & macOS)";

  nixConfig = {
    extra-substituters = [
      "https://wezterm.cachix.org"
    ];
    extra-trusted-public-keys = [
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

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
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: {
    # 1. Garuda Linux Setup (Standalone Home Manager)
    homeConfigurations."shivraj@garuda" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./hosts/garuda/home.nix ];
    };

    # 2. macOS Setup (nix-darwin + Home Manager)
    darwinConfigurations."Shivrajs-MacBook-Air" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/macos/darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.shivraj = import ./hosts/macos/home.nix;
        }
      ];
    };

    darwinConfigurations."macbook" = self.darwinConfigurations."Shivrajs-MacBook-Air";
  };
}
