# Local Workspace

This `.local/` directory is private to this checkout and ignored by git.

Use it for local-only context that helps humans and AI agents work safely on
this deployment without leaking private details into the public repo.

## Agent Reading Order

For non-trivial local work:

1. Read root `AGENTS.md`.
2. Read this file.
3. Read `.local/todo.md` if choosing or continuing work.
4. Read `.local/handoff.md` if taking over from another agent or a prior
   session.
5. Read files under `.local/context/` only as needed.

## Local Files

- `handoff.md`: narrative takeover context.
- `todo.md`: prioritized and categorized local task list.
- `context/host.md`: host machine and local command context.
- `context/network.md`: network, DNS, ingress, and access context.
- `context/agents.md`: AI agents and provider-specific local behavior.
- `context/mcp-and-tools.md`: MCP servers, CLIs, and tool endpoints.
- `context/deployment.md`: private deployment and dogfooding context.
- `context/decisions.md`: local decisions, tradeoffs, and rejected options.
- `scratch/`: disposable drafts and temporary research.

Do not copy content from `.local/` into committed docs without explicit user
approval and sanitization.
