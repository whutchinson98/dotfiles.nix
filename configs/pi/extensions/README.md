# Pi extensions

Store pi extension source files here.

Pi will load these from `~/.pi/agent/extensions` once linked by home-manager.

Examples:

```text
extensions/
├── my-extension.ts
└── larger-extension/
    ├── index.ts
    └── helpers.ts
```

Extension files should default-export a function that receives `ExtensionAPI`.

## Remote MCP extensions

`linear_mcp.ts`, `macro_mcp.ts`, and `pulumi_mcp.ts` use the reusable helper in `mcp_bridge/bridge.ts` to start remote MCP servers. On Linux it uses the Nix/Home Manager `mcp-remote` command; on macOS and other platforms it uses `npx -y mcp-remote`.

Equivalent commands:

```text
# Linux / NixOS
mcp-remote https://mcp.linear.app/sse
mcp-remote https://mcp-server.macro.com/mcp
mcp-remote https://mcp.ai.pulumi.com/mcp

# macOS / other
npx -y mcp-remote https://mcp.linear.app/sse
npx -y mcp-remote https://mcp-server.macro.com/mcp
npx -y mcp-remote https://mcp.ai.pulumi.com/mcp
```

`modules/home/dev/ai.nix` installs `mcp-remote` as a Nix/Home Manager command wrapper for Linux/NixOS. The wrapper currently runs `bunx mcp-remote` with `bun` and `nodejs` in PATH.

Registered tool prefixes and commands:

| Extension | Tool prefix | Commands |
| --- | --- | --- |
| `linear_mcp.ts` | `linear_` | `/linear-mcp-status`, `/linear-mcp-reload` |
| `macro_mcp.ts` | `macro_` | `/macro-mcp-status`, `/macro-mcp-reload` |
| `pulumi_mcp.ts` | `pulumi_` | `/pulumi-mcp-status`, `/pulumi-mcp-reload` |

The first run may require the OAuth flow that `mcp-remote` opens/prompts for.
