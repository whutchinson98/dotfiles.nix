{
  imports = [
    ../../modules/home/terminal.nix
    ../../modules/home/dev.nix
    ../../modules/home/desktop.nix
  ];

  home.packages = [ ];

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
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
}
