# Agent Context

This directory contains provider-neutral context for AI coding agents working on
ChimerAI.

Start with the root [`AGENTS.md`](../../AGENTS.md). It is the canonical source
of shared instructions. Files here provide deeper context that agents should
read only when relevant to the task.

## How To Use This Directory

- Load `AGENTS.md` first.
- Read only the files that match the current task.
- Prefer current repo files over memory or assumptions.
- Keep `.local/` private and out of public documentation unless the user
  explicitly asks to publish sanitized lessons.
- Do not copy local tool instructions, API keys, hostnames, or runtime state
  into tracked files.

## Context Map

| File | Use when |
| --- | --- |
| [`project-philosophy.md`](project-philosophy.md) | Clarifying goals, audience, scope, or positioning. |
| [`architecture.md`](architecture.md) | Designing Ansible roles, Compose runtime behavior, or lifecycle structure. |
| [`implementation-workflow.md`](implementation-workflow.md) | Planning or making code, docs, or infrastructure changes. |
| [`security-and-secrets.md`](security-and-secrets.md) | Working near auth, ingress, secrets, provider keys, or destructive operations. |
| [`documentation-standards.md`](documentation-standards.md) | Editing README, docs, examples, or public contributor guidance. |
| [`provider-compatibility.md`](provider-compatibility.md) | Changing agent instruction files or adding tool-specific setup guidance. |
| [`local-workspace.md`](local-workspace.md) | Using or changing private `.local/` workspace conventions. |

Project-level references:

- [`../architecture-map.md`](../architecture-map.md) gives the compact public
  system map and should be read before changing high-level positioning or
  architecture summaries.
- [`../comparison.md`](../comparison.md) explains how ChimerAI compares with
  nearby self-hosting projects and must stay sourced to official/project docs.
- [`../demo-and-sample-output.md`](../demo-and-sample-output.md) records the
  public demo and evidence plan without inventing unvalidated artifacts.
- [`../installation.md`](../installation.md) defines the repo-local bootstrap
  flow.
- [`../role-contract.md`](../role-contract.md) defines the initial role
  contract.
- [`../role-governance.md`](../role-governance.md) defines role tier, support,
  inclusion, and deprecation policy.
- [`../role-catalog.md`](../role-catalog.md) lists current roles by tier and
  support status.
- [`../inventory-schema.md`](../inventory-schema.md) defines the initial
  inventory shape.
- [`../configuration-and-secrets.md`](../configuration-and-secrets.md) defines
  the SOPS + age encrypted config workflow.
- [`../adr/`](../adr/) records durable architecture decisions.
- [`../milestones/`](../milestones/) records current and planned roadmap
  milestones. Treat this as the public roadmap source of truth.

## Loading Model

- `AGENTS.md` should be loaded by default whenever possible.
- Provider-specific shims may import `AGENTS.md`, but should not duplicate
  policy.
- Long-form context should live here and be read on demand.
- If an AI tool cannot import files directly, point it at `AGENTS.md` first,
  then attach only the specific files from this directory that match the task.
- If `.local/README.md` exists, read it before non-trivial local work. Treat
  `.local/` as private operator context that must not be committed.
- For user-facing setup questions, prefer the current `./install.sh` and
  `chimerai ...` commands over lower-level `uv run ansible-playbook` examples
  unless the user is troubleshooting internals.

## LLM-Friendly Writing Rules

- Use short sections with specific headings.
- State whether behavior is available now or planned.
- Link to canonical docs instead of duplicating long instructions.
- Keep examples safe to copy and free of real secrets.
- Prefer explicit acceptance criteria over vague phrases such as "best
  practices" or "production ready."
