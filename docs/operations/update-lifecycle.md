# Update Lifecycle

Use this sequence to update an existing ChimerAI checkout without guessing which
layer changed.

## Supported Update Path

```bash
git pull
./install.sh
chimerai validate
chimerai apply
```

The installer refreshes local tooling and dependencies. `chimerai validate`
checks inventory and host assumptions before services change. `chimerai apply`
then reconciles generated Compose files, Docker networks, and services.

## Before Updating

- Review release notes, milestone docs, or the diff for changed roles.
- Confirm encrypted local config can still be decrypted.
- Run `chimerai backup` when the target contains state you care about.
- Keep the previous checkout or Git revision available until the apply is
  validated.

## After Updating

- Run `chimerai validate`.
- Run `chimerai apply`.
- Inspect changed tasks and generated Compose diffs when material changes occur.
- Run the service-specific checks that matter for the enabled roles.
- Record sanitized evidence for alpha release candidates.

## Automation Boundary

ChimerAI does not perform automatic updates in the alpha stack. Operators choose
when to pull, validate, apply, and record evidence.
