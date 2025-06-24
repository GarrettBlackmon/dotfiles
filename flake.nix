{
  description = "GLaDOS NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      GLaDOS = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          ./hosts/GLaDOS/default.nix
          inputs.stylix.nixosModules.stylix
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

