{ config, ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = if config.home.username == "work" then "hutch@macro.com" else "will@thehutchery.com";
        name = "Hutch";
      };
      signing = {
        sign-all = true;
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENMDh7q29md/cAQWBp13Fk//buN4KiQIiwJze+rRj9P";
      };
    };
  };
}
