{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../modules/terminal.nix
    ../../modules/desktop.nix
    ../../modules/languages.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [ ];

  home.file = { };

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
}
