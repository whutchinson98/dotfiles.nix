{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hutch";
        email = if config.home.username == "work" then "hutch@macro.com" else "will@thehutchery.com";
      };
      url = {
        "git@github.com:macro-inc/" = {
          insteadOf = "macro:";
        };
        "git@github.com:whutchinson98/" = {
          insteadOf = "me:";
        };
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
