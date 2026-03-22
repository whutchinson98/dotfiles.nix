# Desktop and GUI applications
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
    ./desktop/alacritty.nix
    ./desktop/dunst.nix
    ./desktop/file-manager.nix
    ./desktop/fonts.nix
    ./desktop/niri.nix
    ./desktop/quickshell.nix
  ];

  programs.zen-browser = {
    enable = true;
    profiles.default = {
      isDefault = true;
      path = "default";
    };
  };

  home.packages = with pkgs; [
    notify
    hyprshot
    hyprprop
    signal-desktop
    obsidian
    bruno
    pkgs-stable.spotify
    networkmanagerapplet
    obs-studio
    neomutt
    libnotify
    brave
    ledger-live-desktop
    dbeaver-bin
    proton-vpn-cli
    brightnessctl
  ];
}
