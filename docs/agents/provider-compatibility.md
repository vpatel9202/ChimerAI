# Provider Compatibility

ChimerAI should support agent-assisted development without preferring one model
provider or coding agent.

## Canonical Source

`AGENTS.md` is the canonical source of shared project instructions.

Provider-specific files may exist only to make tools load `AGENTS.md`
automatically. They should not contain independent policy.

## Current Shims

- `CLAUDE.md` imports `AGENTS.md` for Claude Code.
- `GEMINI.md` imports `AGENTS.md` for Gemini CLI.

If these files need more content in the future, keep it limited to
compatibility notes. Move shared instructions back into `AGENTS.md`.

## Direct AGENTS.md Support

Tools such as Codex, Cursor, Windsurf, and other compatible coding agents can
read `AGENTS.md` directly. No additional provider file should be needed for
those tools unless official documentation changes.

## Local Or Custom Agents

For locally hosted or custom agents:

1. Load root `AGENTS.md`.
2. Load only the relevant files from `docs/agents/`.
3. Avoid summarizing `AGENTS.md` into a separate long-term instruction file.
4. If a tool requires a custom context filename, create a thin local shim that
   imports or includes `AGENTS.md`.

## Adding A New Provider Shim

Before committing a new provider-specific file:

- confirm the tool's official context filename and import behavior
- keep the file as a thin import shim
- document the compatibility reason here
- avoid adding model-specific project preferences
