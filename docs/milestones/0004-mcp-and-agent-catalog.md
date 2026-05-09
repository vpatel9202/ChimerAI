# Milestone 4: MCP And Agent Runtime Catalog

Milestone 4 expands ChimerAI from one MCP proof point into a reusable pattern
for MCP servers and agent runtimes.

## Goals

- Add a documented role pattern for private-by-default MCP servers.
- Add at least two MCP roles beyond Todoist.
- Keep MCP endpoints available to host agents and containerized agent runtimes
  without exposing them publicly by default.
- Document safe validation prompts for read-only and mutating tool use.
- Evaluate when provider keys should become shared configuration instead of
  app-local settings.

## Release Gates

- New MCP roles have clear config, validation, and remove behavior.
- Agent runtimes can discover or receive managed MCP registry entries.
- Docs distinguish protocol validation from real LLM/tool validation.
- Secret handling remains SOPS-first and public examples stay placeholder-only.

## Non-Goals

- Building custom MCP servers when maintained upstream servers are suitable.
- Requiring one coding agent, model provider, or runtime.
- Publicly exposing MCP services without an explicit role design.
