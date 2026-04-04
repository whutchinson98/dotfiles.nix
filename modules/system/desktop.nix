# Niri desktop environment — TTY autologin + Wayland compositor
{ config, lib, ... }:
let
  cfg = config.dotfiles.desktop;
in
{
  options.dotfiles.desktop.enable = lib.mkEnableOption "Niri desktop environment";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    security.polkit.enable = true;
  };
}
