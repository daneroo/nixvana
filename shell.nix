{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    fastfetch
    docker-client
  ];

  shellHook = ''
    nixpkgs-fmt
    fastfetch
    echo "Top shell activated"
  '';
}
