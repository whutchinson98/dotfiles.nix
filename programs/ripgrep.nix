let ripgrepConfigPath = ../configs/ripgrep/.ripgreprc;
in {
  programs.ripgrep = { enable = true; };
  home.file.".ripgreprc" = { source = ripgrepConfigPath; };
}
