{
  description = "My Subproject";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      mkShell = system: nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs = with nixpkgs.legacyPackages.${system}; [
          nodejs_21
          # pnpm: will be a global npm install
          fastfetch
        ];

        shellHook = ''
          # Configure npm for global installations
          export NPM_CONFIG_PREFIX=~/.npm-global
          mkdir -p $NPM_CONFIG_PREFIX
          export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
          # Install pnpm globally if not already present
          if [ -z "$(command -v pnpm)" ]; then
            npm install -g pnpm
          fi
          # Display system information on shell start
          # fastfetch
          echo "Subproject flake activated"
        '';
      };
    in
    {
      devShells.x86_64-linux.default = mkShell "x86_64-linux";
      devShells.aarch64-linux.default = mkShell "aarch64-linux";
    };
}
