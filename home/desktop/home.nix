{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../modules/terminal.nix
    ../../modules/desktop.nix
  ];

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
    DEFAULT_BROWSER = "/home/hutch/.nix-profile/bin/zen";
  };

  programs.home-manager.enable = true;
}
