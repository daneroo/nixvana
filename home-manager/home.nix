{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";

  # This value determines the Home Manager release that your configuration is
  # You should not change this value, even if you update Home Manager. If you do
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # The config files were moved to the xdg.configFile option.
    # ".config/direnv/direnv.toml".source = dotfiles/direnv.toml;
    # ".config/starship.toml".source = dotfiles/starship.toml;
    # # You can also set the file content immediately.
    # ".config/yourthing.json".text = ''...'';
  };
  xdg.configFile = {
    "direnv/direnv.toml".source = ./dotfiles/direnv.toml;
    "starship.toml".source = ./dotfiles/starship.toml;
  };

  # Home Manager can also manage your environment variables through
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager = {
      enable = true;
    };
    bash = {
      enable = true; # see note on other shells below
      enableCompletion = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
    };

  };
}
