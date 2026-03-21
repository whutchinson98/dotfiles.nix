{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  playwrightDriver = inputs.playwright-web-flake.packages.${pkgs.stdenv.hostPlatform.system}.playwright-driver;
  playwrightBrowsersPath = builtins.unsafeDiscardStringContext "${playwrightDriver.browsers}";
  mcpConfig = {
    playwright = {
      type = "stdio";
      command = "npx";
      args = [
        "@playwright/mcp@latest"
        "--browser"
        "chromium"
        "--executable-path"
        "$PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH"
      ];
      env = {
        PLAYWRIGHT_BROWSERS_PATH = "$PLAYWRIGHT_BROWSERS_PATH";
        PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
        PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
        PWMCP_PROFILES_DIR_FOR_TEST = "$HOME/.local/share/playwright-mcp/profiles";
        PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH = "$PLAYWRIGHT_BROWSERS_PATH/chromium-1200/chrome-linux64/chrome";
      };
    };
    linear-server = {
      type = "http";
      url = "https://mcp.linear.app/mcp";
    };
  };
  mcpConfigJson = builtins.toJSON mcpConfig;
in
{
  home.packages = with pkgs; [
    claude-code
  ];
  home.activation.configureClaude = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    CLAUDE_CONFIG="$HOME/.claude.json"
    if [ ! -f "$CLAUDE_CONFIG" ]; then
      echo '{}' > "$CLAUDE_CONFIG"
    fi
    MCP_CONFIG=$(echo '${mcpConfigJson}' | ${pkgs.gnused}/bin/sed \
      -e "s|\$PLAYWRIGHT_BROWSERS_PATH|${playwrightBrowsersPath}|g" \
      -e "s|\$HOME|$HOME|g" \
      -e "s|\$PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH|${playwrightBrowsersPath}/chromium-1200/chrome-linux64/chrome|g")
    ${pkgs.jq}/bin/jq --argjson mcpServers "$MCP_CONFIG" \
      '.mcpServers = $mcpServers' \
      "$CLAUDE_CONFIG" > "$CLAUDE_CONFIG.tmp" && \
    mv "$CLAUDE_CONFIG.tmp" "$CLAUDE_CONFIG"
    $VERBOSE_ECHO "Claude Code MCP configuration updated"
  '';
}
