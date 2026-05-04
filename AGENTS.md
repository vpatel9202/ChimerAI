# AGENTS.md

This is the canonical instruction file for AI coding agents working on
ChimerAI. Provider-specific files such as `CLAUDE.md` and `GEMINI.md` must
import this file rather than define separate project policy.

## Project Mission

ChimerAI is a modular, self-hosted AI homelab stack for agents, MCP tools,
automation, and secure operations.

The project is in design/prototype stage. Favor clear architecture, reversible
changes, and public-project maintainability over fast one-off hacks.

## Core Direction

- ChimerAI is Ansible-first for lifecycle, provisioning, validation, backup,
  restore, and diagnostics.
- Docker Compose remains the visible service runtime.
- The public project must stay provider-neutral across Codex, Claude, Gemini,
  local models, and other capable coding agents.
- The repo should make AI-assisted contribution the normal path, while keeping
  humans responsible for review, intent, security, and releases.

## Working Rules

- Inspect the repo before changing it. Do not assume structure that is not
  present yet.
- Prefer small, reviewable changes with clear commit messages.
- Keep public docs honest about prototype status. Do not imply features exist
  before they do.
- Do not commit secrets, credentials, private inventories, local provider
  settings, runtime state, or machine-specific paths.
- Use Markdown for project and agent guidance unless a structured format is
  clearly required.
- Keep provider-specific files as shims only. All shared project policy belongs
  here or in `docs/agents/`.

## Architecture Principles

- Keep host provisioning, service deployment, integration wiring, and
  diagnostics conceptually separate.
- Keep Compose output inspectable and debuggable.
- Prefer app-local state paths over opaque Docker-managed volumes.
- Treat ingress, authentication, secrets, and remote access as first-class
  design concerns.
- Every future role should have a clear validate path.

## Documentation Rules

- README is for humans evaluating or starting with the project.
- `AGENTS.md` is for instructions every agent should load.
- `docs/agents/` is for deeper agent context that should be read on demand.
- Avoid duplicating policy across files. Link to the canonical source instead.
- Use concise, concrete instructions. Avoid vague guidance like "use best
  practices" unless it is followed by project-specific expectations.

## Suggested Reading For Agents

Read only what is relevant to the task:

- `docs/agents/README.md` for the agent context index.
- `docs/agents/project-philosophy.md` for goals, audience, and non-goals.
- `docs/agents/architecture.md` for planned architecture and role shape.
- `docs/agents/implementation-workflow.md` for how to make changes.
- `docs/agents/security-and-secrets.md` before touching auth, ingress,
  secrets, networking, or destructive operations.
- `docs/agents/documentation-standards.md` before changing public docs.
- `docs/agents/provider-compatibility.md` before changing agent instruction
  files or provider-specific shims.
- `docs/agents/local-workspace.md` before changing local-only workspace
  conventions or `.local/` templates.

## Local Workspace

`.local/` is the gitignored workspace for private operator context, active
handoffs, local to-do lists, private inventories, and scratch notes.

- If `.local/README.md` exists, read it before non-trivial local work.
- If `.local/todo.md` exists, read it when choosing or continuing local work.
- If `.local/handoff.md` exists, read it before taking over a large or
  interrupted task.
- Read `.local/context/*` selectively based on the task.
- Never copy `.local/` content into public docs without explicit user approval.
- If a local lesson is generally useful, propose a sanitized public-doc update.

## Validation Expectations

- For documentation-only changes, check links and read the rendered section for
  clarity.
- For future code or Ansible changes, run the most specific validation command
  available and report anything that could not be tested.
- If no validation exists yet, say that plainly and avoid inventing confidence.
