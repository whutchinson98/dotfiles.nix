{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/terminal.nix
    ../../modules/dev-tools.nix
    ../../modules/desktop.nix
  ];

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.file = { };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
