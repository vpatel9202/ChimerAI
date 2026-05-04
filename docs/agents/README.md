# Agent Context

This directory contains provider-neutral context for AI coding agents working on
ChimerAI.

Start with the root [`AGENTS.md`](../../AGENTS.md). It is the canonical source
of shared instructions. Files here provide deeper context that agents should
read only when relevant to the task.

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

## Loading Model

- `AGENTS.md` should be loaded by default whenever possible.
- Provider-specific shims may import `AGENTS.md`, but should not duplicate
  policy.
- Long-form context should live here and be read on demand.
- If an AI tool cannot import files directly, point it at `AGENTS.md` first,
  then attach only the specific files from this directory that match the task.
- If `.local/README.md` exists, read it before non-trivial local work. Treat
  `.local/` as private operator context that must not be committed.
