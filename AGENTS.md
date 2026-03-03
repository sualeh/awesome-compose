# Agents Guide

This repository is designed to be used by automated agents and human collaborators.

## Core Principle

All tasks must be accomplished **using only the skills, code, configuration, and documentation available in this repository** and its declared dependencies. Agents should:

- Prefer existing code, patterns, and tooling defined in this repo over inventing new frameworks or structures.
- Reuse and extend existing modules, configurations, and documentation where possible.
- Avoid relying on undocumented external systems, credentials, or proprietary services unless they are already referenced and configured here.

## Expectations for Agents

- Stay within the architectural, tooling, and style conventions already present in this repository.
- When adding or changing code, keep modifications minimal, focused, and consistent with existing patterns.
- Document new capabilities in the appropriate README or docs/ location so future agents can build on them.

By following these guidelines, agents ensure that all work remains reproducible, transparent, and maintainable from within this repository alone.
