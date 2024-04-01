#!/usr/bin/env bash


# From https://github.com/NixOS/nix/issues/6680#issuecomment-1230902525
# This fixes "suspicious permissions problems" in my nix derivations, however
#  getfacl /tmp ; before and after reveals no differences
echo "Setting up ACLs on /tmp"
# sudo apt update && sudo apt install -y acl && sudo setfacl -k /tmp
sudo sh -c 'apt update && apt install -y acl && setfacl -k /tmp'


### START OF DETERMINATE SYSTEMS NIX INSTALLER PART ###
echo "Determinate Systems Nix installer - no init - (as $(whoami))"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --no-confirm --init none

echo "Source the nix-daemon profile"
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

echo "start nix-daemon (disown/nuhup)"
# Notice the '&' to background the process and 'nohup' to prevent the process from being killed when the shell exits
sudo -n sh -c '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; nohup /nix/var/nix/profiles/default/bin/nix-daemon > /tmp/nix-daemon.log 2>&1 &'

echo "Sleep a bit to let the daemon start"
sleep 1

echo "Proving the nix-daemon is running"
pidof nix-daemon >/tmp/nix-daemon-pid.log

echo "add a default channel (as $(whoami))"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
echo "List channels:"
nix-channel --list

### END OF DETERMINATE SYSTEMS NIX INSTALLER PART ###


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
