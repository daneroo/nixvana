# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## Setup

Following instructions from `nix-devcontainer`:

- `shell.nix` (dependencies for VSCode)
- `flake.nix` (this will be activated by `direnv`)
- `.envrc`: `use_flake`
- `.devcontainer/devcontainer.json` (using docker compose)
  - VSCode Extensions: `customizations.vscode.extensions : [...]`
  - `Dockerfile` just extends `ghcr.io/xtruder/nix-devcontainer:v1` and declares `VOLUME /nix`
  - `compose.yml` - defines two services: `dev` and `docker`
- `.vscode/settings.json` add: `"nixEnvSelector.nixFile": "${workspaceRoot}/shell.nix"`

## References

- [Multiple devcontainers](https://code.visualstudio.com/remote/advancedcontainers/configure-separate-containers)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- GitHub Actions
  - <https://github.com/cachix/install-nix-action>
- CodeSpaces
  - <https://github.com/xtruder/nix-devcontainer>
    - <https://github.com/xtruder/nix-devcontainer-golang>
    - <https://github.com/xtruder/nix-devcontainer-python-jupyter>
