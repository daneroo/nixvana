{
  description = "My development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        nodejs_21
        # pnpm: will be a global npm install
        fastfetch
      ];

      shellHook = ''
        export NPM_CONFIG_PREFIX=~/.npm-global
        mkdir -p $NPM_CONFIG_PREFIX
        export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
        if [ -z "$(command -v pnpm)" ]; then
          npm install -g pnpm
        fi
        echo "subproject shell activated"
        fastfetch
      '';
    };
  };
}
