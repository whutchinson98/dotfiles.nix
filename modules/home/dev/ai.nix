{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    opencode
    pi-coding-agent
    claude-code
  ];
}
