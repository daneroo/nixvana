#!/usr/bin/env bash


# From https://github.com/NixOS/nix/issues/6680#issuecomment-1230902525
# This fixes "suspicious permissions problems" in my nix derivations, however
#  getfacl /tmp ; before and after reveals no differences
echo "Setting up ACLs on /tmp"
sudo sh -c 'apt update -qq && apt install -y -qq acl && setfacl -k /tmp'

# Use Determinate installer to install Nix, if not already installed
if command -v nix >/dev/null 2>&1; then
  echo "Nix is already installed, skipping Determinate installation"
else
  echo "Nix is not installed, installing Nix with Determiate installer - no init - (as $(whoami))"

  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --no-confirm --init none

  echo "Source the nix-daemon profile"
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

  echo "start nix-daemon (disown/nuhup)"
  # Notice the '&' to background the process and 'nohup' to prevent the process from being killed when the shell exits
  sudo -n sh -c '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; nohup /nix/var/nix/profiles/default/bin/nix-daemon > /tmp/nix-daemon.log 2>&1 &'

  # echo "Proving the nix-daemon is running"
  # pidof nix-daemon >/tmp/nix-daemon-pid.log

  # we need a default channel with Determinate installer
  echo "add a default channel (as $(whoami))"
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
  nix-channel --update
  echo "List channels:"
  nix-channel --list
fi
# End of Determinate installer section

# Install home manager from nixpkgs
nix-env -iA nixpkgs.home-manager

# copy the home-manager configuration to the user's home directory
rsync -av --progress ./home-manager/ $HOME/.config/home-manager/
home-manager switch -b backup

echo "Home Manager version: $(home-manager --version)"
echo "Home Manager generations:"
home-manager generations

echo "Nix Store size: $(du -sh /nix/store)"

echo "Post-create (home-manager) command complete in devcontainer"
