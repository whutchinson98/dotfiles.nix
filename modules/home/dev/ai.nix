{
  lib,
  pkgs,
  ...
}:

let
  piAgentPath = ../../../configs/pi/agent;
  piExtensionsPath = ../../../configs/pi/extensions;

  # Nix-friendly wrapper for the npm MCP proxy used by remote MCP pi extensions.
  # It avoids relying on npx being present on NixOS. Use bunx with an explicit
  # package+binary pair so the wrapper does not recursively invoke itself when
  # the wrapper name matches the npm binary name.
  mcpRemote = pkgs.writeShellApplication {
    name = "mcp-remote";
    runtimeInputs = with pkgs; [
      bun
      nodejs
    ];
    text = ''
      exec bunx -p mcp-remote mcp-remote "$@"
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
