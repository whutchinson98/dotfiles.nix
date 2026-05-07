# Planner-builder extension

Creates planner-generated plan files and dispatches plan tasks to builder agents.

## Commands

| Command | Purpose |
| --- | --- |
| `/plan-create <request>` | Run the `planner` agent and write a plan file under `.pi/plans/`. |
| `/plan-build [plan-file] [T01,T02]` | Run `builder` agents for ready tasks in the plan file. If no file is provided, the latest `.pi/plans/*.md` file is used. |
| `/plan-list` | List recent plan files. |

## Tools

| Tool | Purpose |
| --- | --- |
| `plan_file_create` | LLM-callable tool that runs a planner agent and saves a structured plan file. |
| `plan_file_build` | LLM-callable tool that runs builder agents against pending plan tasks. |
| `plan_file_list` | Lists recent plan files. |

## Plan format

The planner is prompted to emit machine-readable builder tasks:

```markdown
## Builder Tasks

### Task T01: Short imperative title
Status: pending
Depends on: none
Files:
- path/to/file.ts
Instructions:
- Specific implementation instruction.
Verification:
- Exact command or manual check.

### Task T02: Follow-up task
Status: pending
Depends on: T01
Files:
- path/to/other-file.ts
Instructions:
- Specific implementation instruction.
Verification:
- Exact command or manual check.
```

`/plan-build` runs all ready tasks in dependency waves. Independent tasks run in parallel, up to the configured max concurrency. Dependent tasks wait until their dependencies have `Status: done`.

Builder agents are instructed not to edit the plan file. The extension updates each task status to `in-progress`, then `done`, `failed`, or `blocked`, and appends a builder result log to the task block.

## Typical workflow

```text
/plan-create add Redis caching to the session store
/plan-list
/plan-build .pi/plans/20260507-180000Z-add-redis-caching-to-the-session-store.md
```

You can also ask naturally: "Use the planner to create a plan file, then have builder agents implement the tasks." The registered tools give the main agent the same workflow.
