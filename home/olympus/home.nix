{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/terminal.nix
    ../../modules/dev-tools.nix
    ../../modules/desktop.nix
  ];

  home.packages = [
    inputs.playwright-web-flake.packages.${pkgs.stdenv.hostPlatform.system}.playwright-driver
  ];

  home.stateVersion = "25.05";

  home.file = { };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        IdentityAgent = "~/.1password/agent.sock";
      };
    };
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
