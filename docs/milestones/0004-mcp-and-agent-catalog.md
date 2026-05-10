# Milestone 4: MCP And Agent Runtime Catalog

Milestone 4 expands beyond the Milestone 2 MCP core set and first OpenClaw
runtime into a broader catalog of MCP servers and agent runtimes.

## Goals

- Add specialized MCP roles beyond filesystem, browser, search, Firecrawl, and
  Todoist.
- Keep MCP endpoints available to host agents and containerized agent runtimes.
- Improve MCP discovery, profiles, permissions, and registry/catalog behavior.
- Add more agent runtimes only after OpenClaw patterns are stable.
- Document safe validation prompts per tool class.

## Release Gates

- New MCP roles have clear config, validation, remove behavior, and permission
  boundaries.
- Agent runtimes can discover or receive managed MCP registry entries.
- Docs distinguish protocol validation from real LLM/tool validation.
- Secret handling remains SOPS-first and public examples stay placeholder-only.

## Non-Goals

- Building custom MCP servers when maintained upstream servers are suitable.
- Requiring one coding agent, model provider, or runtime.
- Publicly exposing MCP services without an explicit role design.
