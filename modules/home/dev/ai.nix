{
  lib,
  pkgs,
  ...
}:

let
  piAgentPath = ../../../configs/pi/agent;
  piExtensionsPath = ../../../configs/pi/extensions;
in
{
  home.packages =
    with pkgs;
    [
      fd
      opencode
      pi-coding-agent
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      libnotify
    ];

  home.file.".pi/agent/APPEND_SYSTEM.md" = {
    source = piAgentPath + /APPEND_SYSTEM.md;
  };

  home.file.".pi/agent/keybindings.json" = {
    source = piAgentPath + /keybindings.json;
  };

  home.file.".pi/agent/skills" = {
    source = piAgentPath + /skills;
    recursive = true;
  };

  home.file.".pi/agent/extensions" = {
    source = piExtensionsPath;
    recursive = true;
  };
}
