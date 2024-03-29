{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    idris2-lsp = { url = "github:idris-community/idris2-lsp"; flake = false; };
  };

  outputs = { home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "trevor";
    in
    {
      homeConfigurations.${username} =

        home-manager.lib.homeManagerConfiguration {
          # Specify the path to your home configuration here
          configuration = import ./home.nix;

          inherit system username;
          homeDirectory = "/home/${username}";
          # Update the state version as needed.
          # See the changelog here:
          # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
          stateVersion = "21.11";

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
    };
}
