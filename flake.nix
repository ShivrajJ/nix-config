{
  description = "Cross-Platform Nix Dotfiles (Garuda/Hades Linux & macOS)";

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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    {
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
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.shivraj = import ./hosts/macos/home.nix;
          }
        ];
      };

      darwinConfigurations."macbook" = self.darwinConfigurations."Shivrajs-MacBook-Air";

      # 3. CachyOS Linux Setup (Standalone Home Manager)
      homeConfigurations."shivraj@Hades" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./hosts/Hades/home.nix ];
      };

      devShells = {
        x86_64-linux.default =
          let
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
          in
          pkgs.mkShell {
            packages = with pkgs; [
              deadnix
              nixfmt
              statix
            ];
          };

        aarch64-darwin.default =
          let
            pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          in
          pkgs.mkShell {
            packages = with pkgs; [
              deadnix
              nixfmt
              statix
            ];
          };
      };

      checks = {
        x86_64-linux.formatting =
          let
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
          in
          pkgs.runCommand "check-formatting"
            {
              nativeBuildInputs = [ pkgs.nixfmt ];
            }
            ''
              cd ${self}
              nixfmt --check $(find . -name '*.nix' -not -path './.git/*')
              touch $out
            '';

        aarch64-darwin.formatting =
          let
            pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          in
          pkgs.runCommand "check-formatting"
            {
              nativeBuildInputs = [ pkgs.nixfmt ];
            }
            ''
              cd ${self}
              nixfmt --check $(find . -name '*.nix' -not -path './.git/*')
              touch $out
            '';
      };

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages."x86_64-linux".nixfmt;
        aarch64-darwin = nixpkgs.legacyPackages."aarch64-darwin".nixfmt;
      };
    };
}
