{ config, ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = if config.home.username == "work" then "hutch@macro.com" else "will@thehutchery.com";
        name = "Hutch";
      };
    };
  };
}
