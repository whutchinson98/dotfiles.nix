# Tailscale VPN — parameterized per host
{ config, lib, ... }:
let
  cfg = config.dotfiles.tailscale;
in
{
  options.dotfiles.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN";
    sshMode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tailscale SSH with --operator=hutch";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if cfg.sshMode then "both" else "client";
      extraUpFlags = lib.optionals cfg.sshMode [ "--ssh" "--operator=hutch" ];
    };
  };
}
