# Zephyr — AMD laptop
{ ... }:
{
  networking.hostName = "zephyr";

  services.fwupd.enable = true;

  dotfiles.fingerprint.enable = true;
  dotfiles.tailscale.enable = true;
  dotfiles.docker.enable = true;
  dotfiles.audio.enable = true;
  dotfiles.desktop.enable = true;
}
