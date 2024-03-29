{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Required by Nix IDE ("jnoortheen.nix-ide") extension
    # nixpkgs-fmt
    # docker-client
    hello
  ];

  shellHook = ''
    echo "Top shell activated"
  '';
}
