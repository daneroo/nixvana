{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
     # hello
     nodejs_20
     # pnpm: will be a global npm install
     deno
     bun
     fastfetch
     docker-client
     curl
     jq
     tree
  ];
  shellHook = ''
    export NPM_CONFIG_PREFIX=~/.npm-global
    mkdir -p $NPM_CONFIG_PREFIX
    export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
    if [ -z "$(command -v pnpm)" ]; then
      npm install -g pnpm
    fi
    echo "top shell activated"
    fastfetch
  '';
}