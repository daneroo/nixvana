# Nixvana

Throwaway repo to show the way to use Nix to create a repeatable development environment.

- Repeatable nix based environment
  - Nix Flakes based
  - CodeSpaces
  - GitHub Actions

## TODO

- [x] swap feature `nix` for determinate installer
- convert home-manager install to flake (install)
- GitHub Actions
- home manager
  - Not working on Codespaces
  - sets up bash, direnv, and starship
  - install home-manager from `nix-env -iA nixpkgs.home-manager` not a home-manager channel
- caching for nix
- coordinate the list of VSCode extensions and their dependencies

## Setup

### Devcontainer - Codespaces (x86_64) & MacOS (aarch64)

We are not using a custom Dockerfile setup, we are only using the `devcontainer.json` file.

- Debian (bookworm/12.5) base image
- features
  - ghcr.io/devcontainers/features/nix:1 enable flakes, install packages: direnv, nixpkgs-fmt
  - ghcr.io/devcontainers/features/docker-in-docker:2
- customizations.vscode.extensions: Nix IDE, Copilot,..

The packages specified in the `nix` feature, are only those required by our VSCode extensions and `direnv`.
They show up in `nix profile list`.

For our other dependencies, we use `flake.nix`, and our `direnv` setup with `.envrc` files in any directory (including the root of the repo).

Our [postCreateCommand](./.devcontainer/post-create-command.sh) script will install the `direnv` hook in our `~/.bashrc` as well as a `~/.config/direnv/direnv.toml` file.

We can see for example that the `subproject/` folder has it's own [`.envrc`](./subproject/.envrc) file, and it's own [`flake.nix`](./subproject/flake.nix) file.

We can also use the non-flake `nix-shell` command to enter a shell with the it's [`shell.nix`](./shell.nix) file.

## References

- [Devcontainer feature:nix](https://github.com/devcontainers/features/blob/main/src/nix/README.md)
- [Multiple devcontainers](https://code.visualstudio.com/remote/advancedcontainers/configure-separate-containers)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- GitHub Actions
  - <https://github.com/cachix/install-nix-action>
- XTruder repo and examples
  - <https://github.com/xtruder/nix-devcontainer>
    - <https://github.com/xtruder/nix-devcontainer-golang>
    - <https://github.com/xtruder/nix-devcontainer-python-jupyter>
