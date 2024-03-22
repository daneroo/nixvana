#!/usr/bin/env bash

# Configure user direnv settings - to allow all .envrc in our container
echo "Configuring user direnv settings..."
mkdir -p ~/.config/direnv
cat << EOF > ~/.config/direnv/direnv.toml
# direnv user config

[global]
# increase warn timeout to 30 minutes
warn_timeout = "30m"

# why is this pointing to the base image's bash?
bash_path = "/bin/bash"

# whitelist all paths for container environment
[whitelist]
prefix = [ "/" ]
EOF

echo "Adding direnv hook to .bashrc..."
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

echo "Nix Store size: $(du -sh /nix/store)"

echo "Post-create command complete in devcontainer"
