{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../modules/terminal.nix
    ../../modules/dev-tools.nix
    ../../modules/desktop.nix
  ];

  home.packages = [
    inputs.playwright-web-flake.packages.${pkgs.system}.playwright-driver
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
