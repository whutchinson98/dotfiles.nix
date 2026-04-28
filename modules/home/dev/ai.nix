{
  lib,
  pkgs,
  ...
}:

let
  piAgentPath = ../../../configs/pi/agent;
  piExtensionsPath = ../../../configs/pi/extensions;

  # Nix-friendly wrapper for the npm MCP proxy used by the Linear pi extension.
  # It avoids relying on npx being present on NixOS. bunx downloads/caches the JS
  # package in the user's home directory; nodejs is on PATH for CLIs with a node shebang.
  mcpRemote = pkgs.writeShellApplication {
    name = "mcp-remote";
    runtimeInputs = with pkgs; [
      bun
      nodejs
    ];
    text = ''
      exec bunx mcp-remote "$@"
    '';
  };
in
{
  home.packages =
    (with pkgs; [
      fd
      opencode
      pi-coding-agent
    ])
    ++ [ mcpRemote ];

  # note: libnotify is part of desktop.nix do not add here

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
