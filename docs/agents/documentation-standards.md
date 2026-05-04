# Documentation Standards

ChimerAI documentation should help humans and AI agents understand intent,
operate safely, and make changes without rediscovering project decisions.

## Style

- Be direct and concrete.
- Say when a feature is planned rather than implemented.
- Prefer short sections and task-oriented headings.
- Use examples that are safe to copy.
- Keep public docs provider-neutral unless documenting compatibility.

## README

The README should be a landing page:

- what ChimerAI is
- how to get started
- what works today
- why it exists
- who it is for
- current status
- planned architecture
- roadmap
- contribution path

Put the current quickstart near the top. Many homelab users will skim, so do
not bury the working install path below long conceptual sections. Avoid
implementation detail in the README; link to deeper docs instead.

Do not include future commands in the main quickstart unless they exist. Planned
interfaces can be discussed in roadmap or explanation docs, clearly marked as
planned.

## Agent Docs

Agent docs should:

- avoid duplicating root `AGENTS.md`
- be split by topic for context management
- clearly state when an agent should read each file
- keep secrets and local deployment details out of source control

## Future Diataxis Shape

As the project grows, organize human docs into:

- tutorials for first successful installs
- how-to guides for specific operations
- reference for inventory, roles, and commands
- explanation for architecture and design tradeoffs
