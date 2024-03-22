{
  description = "My Devcontainer Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      mkShell = system: nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs = with nixpkgs.legacyPackages.${system}; [
          # Nix Formatter
          nixpkgs-fmt
          direnv
          fastfetch
        ];

        shellHook = ''
          echo "Devcontainer flake activated"
        '';
      };
    in
    {
      devShells.x86_64-linux.default = mkShell "x86_64-linux";
      devShells.aarch64-linux.default = mkShell "aarch64-linux";
    };
}
