# Local Workspace

ChimerAI supports a private, gitignored local workspace at `.local/`.

Use it for machine-specific context, private deployment notes, local agent
handoffs, private to-do lists, scratch research, and experimental prompts that
should not become part of the public repository.

## Why `.local/`

ChimerAI is designed for AI-assisted development and operation. Public docs can
describe the project, but each operator will also have private context:

- host machine details
- local network and domain structure
- private deployment choices
- available MCP servers and local tools
- active local tasks
- handoff notes for future agents

That context is useful for local agents, but it usually does not belong in a
public repo.

## Recommended Layout

```text
.local/
├── README.md
├── handoff.md
├── todo.md
├── context/
│   ├── host.md
│   ├── network.md
│   ├── agents.md
│   ├── mcp-and-tools.md
│   ├── deployment.md
│   └── decisions.md
└── scratch/
```

`.local/` is ignored by git. Do not force-add it unless you are deliberately
publishing sanitized examples somewhere else.

## Agent Behavior

Agents should:

- read `.local/README.md` before non-trivial local work, if it exists
- read `.local/todo.md` when choosing or continuing local work, if it exists
- read `.local/handoff.md` before taking over a large or interrupted task, if
  it exists
- read `.local/context/*` selectively based on the task
- never copy `.local/` content into public docs without explicit user approval
- propose a sanitized public-doc update when a local lesson is generally useful

## Templates

Copy these templates into `.local/` and fill them with private context:

- [`templates/local-workspace/README.md`](../../templates/local-workspace/README.md)
- [`templates/local-workspace/handoff.md`](../../templates/local-workspace/handoff.md)
- [`templates/local-workspace/todo.md`](../../templates/local-workspace/todo.md)
- [`templates/local-workspace/host.md`](../../templates/local-workspace/host.md)
- [`templates/local-workspace/network.md`](../../templates/local-workspace/network.md)
- [`templates/local-workspace/agents.md`](../../templates/local-workspace/agents.md)
- [`templates/local-workspace/mcp-and-tools.md`](../../templates/local-workspace/mcp-and-tools.md)
- [`templates/local-workspace/deployment.md`](../../templates/local-workspace/deployment.md)
- [`templates/local-workspace/decisions.md`](../../templates/local-workspace/decisions.md)

Example setup:

```bash
mkdir -p .local/context .local/scratch
cp templates/local-workspace/README.md .local/README.md
cp templates/local-workspace/handoff.md .local/handoff.md
cp templates/local-workspace/todo.md .local/todo.md
cp templates/local-workspace/host.md .local/context/host.md
cp templates/local-workspace/network.md .local/context/network.md
cp templates/local-workspace/agents.md .local/context/agents.md
cp templates/local-workspace/mcp-and-tools.md .local/context/mcp-and-tools.md
cp templates/local-workspace/deployment.md .local/context/deployment.md
cp templates/local-workspace/decisions.md .local/context/decisions.md
```
