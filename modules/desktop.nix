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
    pkgs-stable.signal-desktop
    pkgs-stable.obsidian
    pkgs-stable.jetbrains.datagrip
    pkgs-stable.postman
    pkgs-stable.bruno
    pkgs-stable.spotify
    networkmanagerapplet
    pkgs-stable.protonmail-desktop
    pkgs-stable.obs-studio
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
