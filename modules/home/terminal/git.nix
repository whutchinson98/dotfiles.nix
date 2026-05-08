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
        "git@codeberg.org:hutch/" = {
          insteadOf = "me:";
        };
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
