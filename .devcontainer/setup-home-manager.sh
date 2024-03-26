#!/usr/bin/env bash

# Install home manager from nixpkgs
nix-env -iA nixpkgs.home-manager


echo "Debug PWD: $(pwd)"

# copy the home-manager configuration to the user's home directory
rsync -av --progress ./home-manager/ $HOME/.config/home-manager/
home-manager switch -b backup

echo "Home Manager version: $(home-manager --version)"
echo "Home Manager generations:"
home-manager generations

echo "Nix Store size: $(du -sh /nix/store)"

echo "Post-create (home-manager) command complete in devcontainer"
