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

## Subagents

`subagent/` registers:

| Tool | Purpose |
| --- | --- |
| `agent_list` | List agents discovered from `~/.pi/agent/agents` and, when requested, trusted project `.pi/agents` directories. |
| `subagent` | Spawn one or more agents in isolated `pi --mode json --no-session` subprocesses. |

Subagent subprocesses use `--no-extensions` by default; pass `includeExtensions: true` to the tool only when a delegated agent needs extension-provided tools.

It also registers `/agents [user|project|both]` for interactive discovery.

## Planner-builder workflow

`planner-builder/` registers:

| Tool | Purpose |
| --- | --- |
| `plan_file_create` | Run the `planner` agent and save a structured plan file under `.pi/plans`. |
| `plan_file_build` | Run `builder` agents for ready tasks in a plan file, in dependency-aware parallel waves. |
| `plan_file_list` | List recent plan files. |

It also registers `/plan-create`, `/plan-build`, and `/plan-list`.

## Remote MCP extensions

`linear_mcp.ts` and `pulumi_mcp.ts` use the reusable helper in `mcp_bridge/bridge.ts` to start remote MCP servers. On Linux it uses the Nix/Home Manager `mcp-remote` command; on macOS and other platforms it uses `npx -y mcp-remote`.

Equivalent commands:

```text
# Linux / NixOS
mcp-remote https://mcp.linear.app/mcp
mcp-remote https://mcp.ai.pulumi.com/mcp

# macOS / other
npx -y mcp-remote https://mcp.linear.app/mcp
npx -y mcp-remote https://mcp.ai.pulumi.com/mcp
```

`modules/home/dev/ai.nix` installs `mcp-remote` as a Nix/Home Manager command wrapper for Linux/NixOS. The wrapper runs `npx -y mcp-remote` with Nix's `nodejs` in PATH.

Registered tool prefixes and commands:

| Extension | Tool prefix | Commands |
| --- | --- | --- |
| `linear_mcp.ts` | `linear_` | `/linear-mcp-status`, `/linear-mcp-reload` |
| `pulumi_mcp.ts` | `pulumi_` | `/pulumi-mcp-status`, `/pulumi-mcp-reload` |

The first run may require the OAuth flow that `mcp-remote` opens/prompts for.
