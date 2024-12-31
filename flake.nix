{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    textfox.url = "github:adriankarlen/textfox";
    # using nixpkgs hyprland for now
    # hyprland.url = "github:hyprwm/Hyprland?ref=v0.45.2";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    #hyprpaper.url = "github:hyprwm/hyprpaper";
    #hyprpaper.inputs.hyprland.follows = "hyprland";
    
    #hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    #hyprland-plugins.inputs.hyprland.follows = "hyprland";
    #hy3.url = "github:outfoxxed/hy3?ref=hl0.46.0";
    #hy3.url = "github:outfoxxed/hy3";
    #hy3.inputs.hyprland.follows = "hyprland";
    # hyprchroma = {
    #   url = "github:alexhulbert/hyprchroma";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-unstable, stylix, nixvim, ... }:
  let
    system = "x86_64-linux";
	  overlay-unstable = final: prev: {
	    unstable = nixpkgs-unstable.legacyPackages.${prev.system};
	  };
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.trevor-desktop = nixpkgs.lib.nixosSystem {
	    specialArgs = {inherit nixpkgs-unstable inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
	      stylix.nixosModules.stylix
	      nixvim.nixosModules.nixvim
        #hyprland.nixosModules.default
	      ({config, pkgs, ...}: {nixpkgs.overlays = [overlay-unstable]; })
        home-manager.nixosModules.home-manager
        {
	        home-manager.extraSpecialArgs = { inherit inputs system; }; 
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
