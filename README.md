# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## TODO

- feature/nix flakeUri: Optional URI to a Nix Flake to install in profile.
- home manager
- caching: separate docker compose volume? https://cache.nixos.org vs cachix?
- docker: will require compose.yml
- coordinate the list of VSCode extensions and their dependencies

## Devcontainer - Codespaces & MacOS (aarch64)

- Starting over with:

  - Ubuntu jammy/22.04 + `features/nix:1` + `extraNixConfig:flakes` + `packages: ..,nixpkgs-fmt..`
  - [x] Debian bookworm/12.5

- [xtruder's configs](https://github.com/xtruder/nix-devcontainer/tree/main),
  - `.devcontainer/xtruder` folder.
  - included `compose.yml` file to get `docker-dind` working
  - does not work on OSX (aarch64 at least)

### Setup (xtruder)

Following instructions from `nix-devcontainer`:

- `shell.nix` (dependencies for VSCode) - but now using `features:nix/packages`
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
