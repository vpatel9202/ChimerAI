# Implementation Workflow

Agents should treat ChimerAI like a public infrastructure project, not a private
scratch repo.

## Before Editing

- Inspect current files and git status.
- Identify whether the task is documentation, architecture, role work,
  validation, or release hygiene.
- Read the relevant `docs/agents/` context file instead of loading everything.
- If a high-impact product decision is unclear, ask before implementing.

## While Editing

- Make focused, reviewable changes.
- Keep generated examples generic and public-safe.
- Avoid machine-specific paths unless clearly marked as examples.
- Prefer explicit links over duplicated instructions.
- Do not add provider-specific policy outside `AGENTS.md`.

## After Editing

- Run the most relevant validation available.
- For docs, check links and read the changed section for clarity.
- For future Ansible work, run syntax checks or dry-runs where available.
- Leave the worktree state clear in the final report.

## Commit Guidance

Use concise commit messages that describe behavior or project structure, for
example:

- `Add provider-neutral agent instructions`
- `Define initial Ansible role contract`
- `Document Todoist MCP role design`
