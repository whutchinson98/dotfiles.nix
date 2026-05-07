{
  lib,
  pkgs,
  ...
}:

let
  piAgentPath = ../../../configs/pi/agent;
  piExtensionsPath = ../../../configs/pi/extensions;

  # Nix-friendly wrapper for the npm MCP proxy used by remote MCP pi extensions.
  # Use npx from Nix's nodejs package. bunx is tempting, but `bunx -p
  # mcp-remote mcp-remote` resolves the mcp-remote executable from PATH first on
  # this system, which recursively calls this wrapper and exits before the MCP
  # stdio server starts.
  mcpRemote = pkgs.writeShellApplication {
    name = "mcp-remote";
    runtimeInputs = with pkgs; [
      nodejs
    ];
    text = ''
      export NPM_CONFIG_UPDATE_NOTIFIER=false
      exec npx -y mcp-remote "$@"
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
