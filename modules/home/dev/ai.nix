{
  pkgs,
  ...
}:

let
  piAgentPath = ../../../configs/pi/agent;
  piExtensionsPath = ../../../configs/pi/extensions;
in
{
  home.packages = with pkgs; [
    opencode
    pi-coding-agent
    claude-code
  ];

  home.file.".pi/agent/APPEND_SYSTEM.md" = {
    source = piAgentPath + /APPEND_SYSTEM.md;
  };

  home.file.".pi/agent/extensions" = {
    source = piExtensionsPath;
    recursive = true;
  };
}
