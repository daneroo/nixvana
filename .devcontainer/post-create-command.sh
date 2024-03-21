#!/usr/bin/env bash

# direnv allow
direnv allow

# add direnv hook to .bashrc
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

echo "Post-create command complete."