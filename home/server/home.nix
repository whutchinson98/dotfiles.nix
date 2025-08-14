{ config, pkgs, ... }: {
  imports = [
    ../../modules/terminal.nix
    ../../modules/languages.nix
    ../../modules/dev-tools.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [ ];

  home.file = { };

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
}
