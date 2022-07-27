{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nipkgs.follows = "nixpkgs";
    # rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {

    nixosConfigurations.trevor-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./kmonad-module.nix
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
