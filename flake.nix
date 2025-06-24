{
  description = "GLaDOS NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    nixai.url = "github:olafkfreund/nix-ai-help";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.GLaDOS = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/GLaDOS/default.nix
        inputs.agenix.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        #home-manager configs
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.garrett = import ./users/garrett-home.nix;
          home-manager.backupFileExtension = ".bak";
        }
      ];
    };
  };
}
