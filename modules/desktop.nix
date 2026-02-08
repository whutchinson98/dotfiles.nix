{
  config,
  pkgs,
  pkgs-stable,
  ...
}:

{
  xdg.desktopEntries.brave-browser = {
    name = "Brave (Hidden)";
    exec = "brave";
    noDisplay = true;
  };

  home.packages = with pkgs; [
    notify
    hyprshot
    hyprprop
    signal-desktop
    obsidian
    pkgs-stable.jetbrains.datagrip
    pkgs-stable.postman
    bruno
    pkgs-stable.spotify
    networkmanagerapplet
    protonmail-desktop
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
