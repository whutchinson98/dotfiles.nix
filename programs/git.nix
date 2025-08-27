{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Hutch";
    userEmail = if config.home.username == "work" then "hutch@macro.com" else "will@thehutchery.com";
    extraConfig = {
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
