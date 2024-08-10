{
  description = "NixOS configuration";

  inputs = {
    # idris2-pkgs.url = "github:jeroendehaas/idris2-pkgs";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-unstable, ... }:
    let
        system = "x86_64-linux";
	overlay-unstable = final: prev: {
	unstable = nixpkgs-unstable.legacyPackages.${prev.system};
	};
    in
    {
      nixosConfigurations.trevor-desktop = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit nixpkgs-unstable; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
	  ({config, pkgs, ...}: {nixpkgs.overlays = [overlay-unstable]; })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.trevor = import ./home/home.nix;
          }
        ];
      };
      nixosConfigurations.trevor-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./laptop/configuration.nix
          ./laptop/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.trevor = import ./home/home.nix;
          }
        ];
      };
    };
}
