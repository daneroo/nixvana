#!/usr/bin/env bash

# Configure global direnv settings - to allow all .envrc in our container
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

# add direnv hook to .bashrc
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc


echo "Post-create command complete."
