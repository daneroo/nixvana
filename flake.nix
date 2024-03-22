{
  description = "My development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      mkShell = system: nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs = with nixpkgs.legacyPackages.${system}; [
          direnv
          # Nix Formatter
          nixpkgs-fmt
          # Node.js LTS version
          nodejs_20
          # pnpm: will be a global npm install in shellHook
          deno
          bun
          fastfetch
          docker
          curl
          jq
          tree
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
          echo "Top flake activated"
        '';
      };
    in
    {
      devShells.x86_64-linux.default = mkShell "x86_64-linux";
      devShells.aarch64-linux.default = mkShell "aarch64-linux";
    };
}
