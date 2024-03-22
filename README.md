# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## TODO

- home manager
- caching:
- [x] docker is a feature
- remove xtruder and ubuntu
- coordinate the list of VSCode extensions and their dependencies

## Devcontainer - Codespaces (x86_64) & MacOS (aarch64)

- features:ghcr.io/devcontainers/features/nix:1:{flakes,packages:fastfetch,direnv,nixpkgs-fmt}
  - [x] Ubuntu jammy/22.04 + `features/nix:1` + `extraNixConfig:flakes` + `packages: ..,nixpkgs-fmt..`
  - [x] Debian bookworm/12.5 + `features/nix:1` + `extraNixConfig:flakes` + `packages: ..,nixpkgs-fmt..`
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

- [Devcontainer feature:nix](https://github.com/devcontainers/features/blob/main/src/nix/README.md)
- [Multiple devcontainers](https://code.visualstudio.com/remote/advancedcontainers/configure-separate-containers)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- GitHub Actions
  - <https://github.com/cachix/install-nix-action>
- CodeSpaces
  - <https://github.com/xtruder/nix-devcontainer>
    - <https://github.com/xtruder/nix-devcontainer-golang>
    - <https://github.com/xtruder/nix-devcontainer-python-jupyter>
