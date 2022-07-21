{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nipkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ...}: {

    nixosConfigurations.trevor-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        # ./nix/common.nix
        # ./nix/control.nix
        # ./nix/devices.nix
        # ./nix/users/nadleeh/hardware-configuration.nix
        # ./nix/users/nadleeh/nadleeh.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.trevor   = import ./home/home.nix;
        }
      ];
    };
  };
}
