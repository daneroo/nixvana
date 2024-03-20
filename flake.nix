{
  description = "My development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        # Node.js LTS version
        nodejs_20
        # pnpm: will be a global npm install in shellHook
        deno
        bun
        fastfetch
        docker-client
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
        fastfetch
        echo "Top flake activated"
      '';
    };
  };
}
