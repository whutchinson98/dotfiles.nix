# Niri desktop environment — SDDM display manager + Wayland compositor
{ config, lib, ... }:
let
  cfg = config.dotfiles.desktop;
in
{
  options.dotfiles.desktop.enable = lib.mkEnableOption "Niri desktop environment";

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    programs.niri.enable = true;
    security.polkit.enable = true;
  };
}
