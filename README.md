# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## Setup

Following instructions from `nix-devcontainer`:

- `shell.nix` (actuall dependencies
  - npm global install in `shellHook`
- `.envrc`: `use_nix`
- `.devcontainer/devcontainer.json` (using docker compose)
  - `Dockerfile` just extends `ghcr.io/xtruder/nix-devcontainer:v1` and delclares `VOLUME /nix`
  - `compose.yml` - defines two services: `dev` and `docker`
- `.vscode/settings.json` add: `"nixEnvSelector.nixFile": "${workspaceRoot}/shell.nix"`

## References

- [nix-direnv](https://github.com/nix-community/nix-direnv)
- GitHub Actions
  - <https://github.com/cachix/install-nix-action>
- CodeSpaces
  - <https://github.com/xtruder/nix-devcontainer>
    - <https://github.com/xtruder/nix-devcontainer-golang>
    - <https://github.com/xtruder/nix-devcontainer-python-jupyter>
