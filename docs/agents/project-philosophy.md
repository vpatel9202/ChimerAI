# Project Philosophy

ChimerAI exists because self-hosted AI tooling is powerful but fragmented.
Users can deploy chat UIs, local models, automation engines, MCP servers,
memory systems, and reverse proxies, but turning those pieces into an
operable foundation still requires too much manual glue.

## Goal

Build a modular, reproducible, self-hosted AI operations foundation for
agents, MCP tools, workflow automation, secure access, memory, and operations.
App roles prove the platform and provide useful integrations; they are not the
product by themselves.

## Audience

ChimerAI is for homelab operators, developers, and technically comfortable
users who want to run an inspectable AI operations platform on a VPS or home
server.

The project assumes users can read YAML, use a terminal, and review generated
configuration. It should not assume they are Ansible experts.

## Non-Goals

- Do not become a hosted SaaS product.
- Do not become a Kubernetes distribution.
- Do not hide Docker Compose behind an opaque abstraction.
- Do not become a generic Compose file or app bundle collection.
- Do not try to package every AI app before the core lifecycle is reliable.
- Do not require one model provider, one agent runtime, or one ingress provider.

## AI-First Ethos

ChimerAI should be designed for agent-assisted operation. Users should be able
to ask a capable AI coding agent to add a role, validate a stack, improve docs,
or troubleshoot a deployment.

That does not mean unattended autonomy. Human review, explicit intent, safe
defaults, and reproducible validation remain mandatory.
