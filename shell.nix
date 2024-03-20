{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
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
    echo "Top shell activated"
    fastfetch
  '';
}
