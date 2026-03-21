# Docker — rootless container runtime
{ config, lib, pkgs, ... }:
let
  cfg = config.dotfiles.docker;
in
{
  options.dotfiles.docker.enable = lib.mkEnableOption "Docker";

  config = lib.mkIf cfg.enable {
    users.groups.docker = { };
    environment.systemPackages = with pkgs; [ docker docker-buildx ];
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
      rootless.enable = true;
    };
    users.users.hutch.extraGroups = [ "docker" ];
  };
}
