# Desktop and GUI applications
{
  config,
  pkgs,
  pkgs-stable,
  ...
}:
{
  imports = [
    ./desktop/alacritty.nix
    ./desktop/dunst.nix
    ./desktop/file-manager.nix
    ./desktop/fonts.nix
    ./desktop/niri.nix
    ./desktop/quickshell.nix
    #./desktop/waybar.nix
  ];

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
