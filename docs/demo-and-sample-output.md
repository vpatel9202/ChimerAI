# Demo and Sample Output

ChimerAI should publish demo material only when it comes from real validation.
This page records the plan without faking screenshots, logs, or sample output.

## Current State

No public demo artifact is claimed here yet. The project has documentation,
contracts, and validation plans, but this page should not pretend a completed
demo exists before evidence is captured.

## Planned Demo Path

The first useful demo should show:

1. Fresh checkout bootstrap with `./install.sh`.
2. `chimerai validate` output for the prepared environment.
3. A dry, readable explanation of what would change before apply where
   supported.
4. A successful apply against the current validation target.
5. Generated Compose/runtime inspection for at least one managed service.
6. Diagnostics output.
7. Backup and restore evidence when those paths are in scope for the milestone.
8. Remove or cleanup behavior where supported.

## Evidence Rules

- Use sanitized output captured from real commands.
- Remove hostnames, domains, secrets, tokens, IPs, and private inventories.
- Keep command output short enough for a reader to understand the behavior.
- Link to the relevant validation record when a release gate depends on the
  demo.
- Mark planned examples as planned until evidence exists.

## Future Artifacts

Expected public artifacts may include:

- Short terminal transcript.
- Sanitized validation record excerpt.
- Generated Compose excerpt.
- Architecture diagram derived from the current docs.
- Troubleshooting example for one common failure mode.

Do not add placeholder screenshots or invented command output.
