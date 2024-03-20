{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    fastfetch
    docker-client
  ];

  shellHook = ''
    fastfetch
    echo "Top shell activated"
  '';
}
