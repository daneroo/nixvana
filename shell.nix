{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    fastfetch
    docker-client
  ];

  shellHook = ''
    fastfetch
    echo "Top shell activated"
  '';
}
