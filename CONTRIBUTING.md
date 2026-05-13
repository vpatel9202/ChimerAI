# Contributing

ChimerAI is still in design/prototype stage.

At this point, the most useful contributions are design feedback, issue reports,
small documentation improvements, and focused improvements to the initial
Ansible contract.

ChimerAI is not ready for broad support requests, app-store requests, or large
feature pull requests without prior agreement. Please keep issues and pull
requests narrow enough for maintainers to review against the current prototype
contracts.

Use the available issue templates:

- bug reports for reproducible behavior in the repo, generated config,
  validation, or documented workflows;
- role requests for proposed managed services that need governance review;
- pull requests for focused docs, tests, validation, or approved implementation
  changes.

Before proposing role changes, read:

- [`docs/installation.md`](docs/installation.md)
- [`docs/role-governance.md`](docs/role-governance.md)
- [`docs/role-catalog.md`](docs/role-catalog.md)
- [`docs/role-contract.md`](docs/role-contract.md)
- [`docs/inventory-schema.md`](docs/inventory-schema.md)

## Role Requests And Contributions

Start with the
[role request issue template](.github/ISSUE_TEMPLATE/role_request.md) before
adding a new role. The request should state the operational problem, proposed
tier, support owner, validation path, secrets and networking impact, and why the
work belongs in ChimerAI instead of remaining a local Compose wrapper.

A role request is a design and governance gate, not a promise that ChimerAI will
package every useful application. New roles need a maintainer who can keep the
role healthy through upstream changes, validation updates, backup and restore
expectations, and eventual deprecation or removal.

Implementation pull requests for roles must:

- add or update the role entry in [`docs/role-catalog.md`](docs/role-catalog.md);
- follow the inclusion criteria in
  [`docs/role-governance.md`](docs/role-governance.md);
- document lifecycle, validation, state, secrets, ingress, and auth behavior;
- include a removal or deprecation plan when replacing an existing role.

Before submitting implementation changes, run the relevant local validation:

```bash
bash -n install.sh
bash -n bin/chimerai
uv run ansible-playbook chimerai.yml --syntax-check
uv run ansible-playbook chimerai.yml --check
```

If you have initialized local encrypted config, `chimerai validate` is the
preferred end-to-end validation wrapper.

Before opening large implementation pull requests, please start with an issue or
discussion so the design can be agreed on first.
