{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
     # hello
     nodejs_20
     # pnpm
     deno
     bun
     # fastfetch
  ];
}