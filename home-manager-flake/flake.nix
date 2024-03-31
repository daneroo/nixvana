{
  description = "VSCode devcontainer with Home Manager setup";

  inputs = {
    # The NixOS unstable channel provides the latest packages and features.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # The Home Manager from the main branch, akin to using an unstable channel for it.
    home-manager.url = "github:nix-community/home-manager";
    # Flake utils for simplifying flake creation, especially for multi-system support.
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      # Import the package set from nixpkgs for the current system.
      pkgs = import nixpkgs { inherit system; };
      # Import Home Manager with the system's package set.
      hm = import home-manager { inherit pkgs; };
    in {
      # Define the Home Manager configurations for available systems.
      homeConfigurations = {
        vscode = hm.lib.homeManagerConfiguration {
          inherit pkgs;
          # Home Manager's configuration requires specifying the user and their home directory.
          username = "vscode";
          homeDirectory = "/home/vscode"; 
          stateVersion = "23.11";
          configuration = import ./home.nix { 
            inherit pkgs;
            dotfiles = ./dotfiles;
          };
        };
      };
    });
}
