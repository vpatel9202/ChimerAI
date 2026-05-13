# Implementation Workflow

Agents should treat ChimerAI like a public infrastructure project, not a private
scratch repo.

## Before Editing

- Inspect current files and git status.
- Identify whether the task is documentation, architecture, role work,
  validation, or release hygiene.
- Read the relevant `docs/agents/` context file instead of loading everything.
- Before proposing or adding roles, check `docs/role-governance.md` and
  `docs/role-catalog.md`.
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
- For shell changes, run `bash -n install.sh` or `bash -n bin/chimerai` as
  relevant.
- For Ansible work, run `uv run ansible-playbook chimerai.yml --syntax-check`.
- For lifecycle behavior, prefer `chimerai validate` when an encrypted local
  config exists; otherwise use `uv run ansible-playbook chimerai.yml --check`.
- Leave the worktree state clear in the final report.

## Commit Guidance

Use concise commit messages that describe behavior or project structure, for
example:

- `Add provider-neutral agent instructions`
- `Define initial Ansible role contract`
- `Document Todoist MCP role design`

## Public Setup Commands

When writing user-facing docs, prefer the high-level flow:

```bash
./install.sh
chimerai config init
chimerai validate
```

Use lower-level `uv run ansible-playbook ...` examples only when documenting
internals or troubleshooting.
