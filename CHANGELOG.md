# Changelog

All notable changes to ChimerAI will be documented in this file.

The project has not published a release yet.

## Unreleased

- Created initial project README.
- Added provider-neutral agent instructions and compatibility shims.
- Added `.local/` workspace convention and templates.
- Defined the initial role contract and inventory schema.
- Added uv-managed Ansible tooling with a parseable dry-run skeleton.
- Added GitHub Actions validation for the Milestone 0 Ansible dry run.
- Added a foundational architecture decision record.
- Added Milestone 1 core role behavior for validation, Docker checks, networks,
  diagnostics, and Open WebUI.
- Added SOPS + age support for an encrypted single-file private configuration
  workflow.
- Added `bin/chimerai` wrapper commands for config initialization, editing,
  validation, and basic Ansible lifecycle actions.
- Added repo-local `install.sh` bootstrap script for local tooling, CLI linking,
  and Ansible dependency setup.
- Reworked user-facing and agent-facing documentation around the current
  installer, CLI, SOPS config, and Milestone 1 proof of concept.
- Added Milestone 2 roles for Traefik ingress, Authentik shared auth, and
  OpenClaw, with bind-mounted app state and an OpenClaw onboarding helper.
- Added Todoist MCP role wiring for OpenClaw, including private MCP networking,
  managed registry configuration, and diagnostics.
- Tightened user-facing and agent-facing documentation for durable roadmap,
  alpha boundaries, and LLM-ingestion guidance.
