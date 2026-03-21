# Olympus — AMD desktop
{ ... }:
{
  networking.hostName = "olympus";

  services.openssh.enable = true;

  dotfiles.tailscale = {
    enable = true;
    sshMode = true;
  };
  dotfiles.docker.enable = true;
  dotfiles.audio.enable = true;
  dotfiles.desktop.enable = true;
  dotfiles.zsa-keyboard.enable = true;
}
