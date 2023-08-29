{
  description = "NixOS configuration";

  inputs = {
    # idris2-pkgs.url = "github:jeroendehaas/idris2-pkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    # rust-overlay.url = "github:oxalica/rust-overlay";
  };

  # outputs = inputs@{ self, nixpkgs, home-manager, idris2-pkgs, ... }:
  outputs = inputs@{ self, nixpkgs, home-manager, ... }:

    let
        system = "x86_64-linux";
      # overlays = [
      #   inputs.idris2-pkgs.overlay
      # ];
      # pkgs = import nixpkgs {
      #   inherit system overlays;
      #   config = { allowUnfree = true; };
      # };
    in
    {
      nixosConfigurations.trevor-desktop = nixpkgs.lib.nixosSystem {
        # inherit pkgs;
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          # ({ pkgs, ... }:{
          #   nixpkgs.overlays = [ rust-overlay.overlay ];
          #   environments.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          # })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.trevor = import ./home/home.nix;
          }
        ];
      };
      nixosConfigurations.trevor-laptop = nixpkgs.lib.nixosSystem {
        # inherit pkgs;
        system = "x86_64-linux";
        modules = [
          ./laptop/configuration.nix
          ./laptop/hardware-configuration.nix
          # ({ pkgs, ... }:{
          #   nixpkgs.overlays = [ rust-overlay.overlay ];
          #   environments.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          # })
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
