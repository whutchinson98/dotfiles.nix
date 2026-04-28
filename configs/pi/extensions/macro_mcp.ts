import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { mcpRemoteCommand, registerMcpBridge } from "./mcp_bridge/bridge";

const MACRO_MCP_URL = "https://mcp-server.macro.com/mcp";

export default function (pi: ExtensionAPI) {
  registerMcpBridge(pi, {
    serverName: "Macro",
    toolPrefix: "macro",
    ...mcpRemoteCommand(MACRO_MCP_URL),
    startupTimeoutMs: 120_000,
    requestTimeoutMs: 60_000,
    promptGuidelines: [
      "Use macro_* tools when the user asks about Macro or needs information/actions from the Macro MCP server.",
      "Prefer read-only macro_* tools before mutating Macro data; summarize intended Macro changes before performing mutations unless the user explicitly requested the mutation.",
    ],
  });
}
