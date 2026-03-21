{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "will@thehutchery.com";
        name = "Hutch";
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
