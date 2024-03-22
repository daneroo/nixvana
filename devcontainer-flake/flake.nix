{
  description = "My Devcontainer Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      mkProfile = system: nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          # Nix Formatter
          nixpkgs-fmt
          direnv
          fastfetch
        ];

        shellHook = ''
          echo "Devcontainer flake profile activated"
        '';
      };
    in
    {
      packages.x86_64-linux.default = mkProfile "x86_64-linux";
      packages.aarch64-linux.default = mkProfile "aarch64-linux";
    };
}
