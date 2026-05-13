---
name: Bug report
about: Report reproducible ChimerAI behavior
title: "[Bug]: "
labels: bug
assignees: ""
---

## Summary

Describe what happened and what you expected.

## Environment

- Host OS and version:
- CPU architecture:
- Docker version:
- Docker Compose version:
- Ansible or `uv` version, if relevant:
- ChimerAI commit:
- Install method or command path:
- Command run:
- Inventory shape, if relevant:
  - single host or multiple hosts:
  - local VM, bare metal, VPS, or containerized test host:

## Reproduction

Provide the smallest repeatable sequence.

1.
2.
3.

Include:

- what you expected;
- what happened instead;
- whether the issue happens on a fresh checkout or only after prior local state;
- whether generated files, encrypted config, or existing Docker resources were
  already present.

## Validation Output

Paste relevant non-secret output from `chimerai validate`, `chimerai apply`, or
the failing command. Prefer the shortest output that still shows the failure.

## Local Changes

- [ ] I checked whether the issue reproduces with unrelated local edits removed.
- [ ] I listed any intentional local changes that may affect the result.
- [ ] I confirmed this report does not rely on private `.local/` content.

## Safety Check

- [ ] I removed secrets, tokens, private hostnames, private inventories, and
      generated `.env` content.
- [ ] I replaced real domain names, IP addresses, emails, and user names when
      they are not needed to reproduce the issue.
- [ ] I reviewed logs for credentials, session cookies, API keys, and encrypted
      inventory contents before pasting.
