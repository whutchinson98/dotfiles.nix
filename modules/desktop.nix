{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    notify
    hyprshot
    hyprprop
    signal-desktop
    discord
    obsidian
    jetbrains.datagrip
    postman
    spotify
    networkmanagerapplet
    protonmail-desktop
    obs-studio
  ];

  imports = [
    ../programs/hyprland.nix
    ../programs/waybar.nix
    ../programs/niri.nix
    ../programs/file_manager.nix
    ../programs/alacritty.nix
    ../programs/fonts.nix
    ../programs/dunst.nix
  ];

  programs.zen-browser.enable = true;
}
