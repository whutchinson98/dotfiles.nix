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
    pkgs-stable.jetbrains.datagrip
    pkgs-stable.postman
    bruno
    pkgs-stable.spotify
    networkmanagerapplet
    protonmail-desktop
    obs-studio
  ];

  imports = [
    ../programs/fonts.nix
    ../programs/waybar.nix
    ../programs/niri.nix
    ../programs/file_manager.nix
    ../programs/alacritty.nix
    ../programs/dunst.nix
  ];

  programs.zen-browser.enable = true;
}
