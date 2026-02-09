{
  config,
  pkgs,
  pkgs-stable,
  ...
}:

{
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
  ];

  imports = [
    ../programs/fonts.nix
    ../programs/niri.nix
    ../programs/waybar.nix
    ../programs/file_manager.nix
    ../programs/alacritty.nix
    ../programs/dunst.nix
  ];
}
