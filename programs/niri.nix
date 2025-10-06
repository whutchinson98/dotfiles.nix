{ pkgs, ... }:

let
  configPath = ../configs/niri;
in
{

  home.packages = with pkgs; [
    swaylock
    fuzzel
    xwayland-satellite
  ];

  home.file.".config/niri" = {
    source = configPath;
    recursive = true;
  };
}
