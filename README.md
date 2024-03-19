# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## Setup

Following instructions from `nix-devcontainer`:

- minimal `shell.nix` (just echo)
- `.envrc`: `use_nix`
- `.devcontainer/devcontainer.json` (using Dockerfile first)
- `Dockerfile` just extends `ghcr.io/xtruder/nix-devcontainer:v1`
- `.vscode/settings.json` add: `"nixEnvSelector.nixFile": "${workspaceRoot}/shell.nix"`

## References

- <https://github.com/xtruder/nix-devcontainer>
  - <https://github.com/xtruder/nix-devcontainer-golang>
  - <https://github.com/xtruder/nix-devcontainer-python-jupyter>
