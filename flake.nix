{
  description = "GLaDOS NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, agenix, home-manager, ... }: {
    nixosConfigurations = {
      GLaDOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/GLaDOS/default.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.garrett = import ./users/garrett-home.nix;
          }
        ];
      };
    };
  };
}

