# Milestone 5: Operations Maturity

Milestone 5 focuses on running ChimerAI over time: updates, diagnostics,
recovery, and operator confidence.

## Goals

- Define the supported update path for image tags, rendered config, and role
  changes.
- Expand diagnostics into service-specific checks with actionable failures.
- Add backup and restore drills for the alpha stack.
- Document log inspection, port exposure review, and health-check workflows.
- Decide which remote access profiles belong in the public project.
- Mature notifications, audit trails, and runner/sandbox operations.

## Release Gates

- Operators can update an existing checkout without guessing which commands to
  run.
- Restore documentation has been tested against a clean recovery path.
- Diagnostics explain what failed and what to inspect next.
- Security guidance covers the operational lifecycle, not only first install.
- Operators can review tool calls, notifications, and runner activity without
  reading raw container logs first.

## Non-Goals

- Multi-host orchestration before single-host operations are stable.
- A custom UI or app catalog before role contracts have settled.
- Hidden orchestration that makes generated Compose harder to debug.
