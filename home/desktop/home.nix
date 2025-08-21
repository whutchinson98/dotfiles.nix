{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../modules/terminal.nix
    ../../modules/desktop.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [ 
    #inputs.github-notifier.packages.${pkgs.system}.default
  ];

  home.file = { };


  home.sessionVariables = { 
    EDITOR = "nvim"; 
  };

  programs.home-manager.enable = true;
}
