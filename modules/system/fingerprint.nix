{ config, lib, ... }:
{
  options.dotfiles.fingerprint.enable = lib.mkEnableOption "fingerprint reader support";

  config = lib.mkIf config.dotfiles.fingerprint.enable {
    services.fprintd.enable = true;

    security.pam.services.polkit-1.fprintAuth = true;
  };
}
