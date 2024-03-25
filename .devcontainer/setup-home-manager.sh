#!/usr/bin/env bash

###
# TODO(daneroo): This is a work in progress, and is meant to replatce the post-create-command.sh
###

# Configure home manager channel - unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# Configure home manager channel - 23.11 release
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
# Now updte the channel
nix-channel --update

# Install home manager
nix-shell '<home-manager>' -A install

echo "Debug PWD: $(pwd)"
# copy the home.nix file to the user's home directory
cp ./home-manager/home.nix /home/vscode/.config/home-manager/home.nix
# home-manager switch
home-manager switch -b backup

# echo "Adding direnv hook to .bashrc..."
# echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

echo "Nix channels:"
nix-channel --list
echo "Home Manager version: $(home-manager --version)"
echo "Home Manager generations:"
home-manager generations

echo "Nix Store size: $(du -sh /nix/store)"

echo "Post-create (home-manager) command complete in devcontainer"
