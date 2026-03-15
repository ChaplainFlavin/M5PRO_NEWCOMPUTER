# ai-workbench

This repository is the portable AI workbench for the new Mac.

It is not a business project repo. It stores the reusable assets that
must be available on day one:

- custom skills
- agent workflows
- prompt libraries
- reusable docs and templates
- working memory and resume notes
- helper scripts
- machine bootstrap notes

## Planned Layout

- `skills/`
  - active custom skills copied from `.claude/skills/`
- `workflows/`
  - agent workflow docs copied from `.agents/workflows/`
- `prompts/`
  - reusable prompt libraries and prompt packs
- `docs/`
  - reusable written assets, SOPs, templates, and reference docs
- `memory/`
  - working memory, handoff notes, and "continue tomorrow" files
- `scripts/`
  - helper scripts used across machines
- `bootstrap/`
  - setup notes and recovery instructions for the new Mac
- `staging/`
  - temporary import area before files are sorted

## Import Priority

1. `skills/`
2. `workflows/`
3. `prompts/`
4. `memory/`
5. `docs/`
6. `scripts/`
7. `bootstrap/`

## Rules

- Do not commit secrets, tokens, cookies, or local auth state.
- Do not commit caches, virtualenvs, or generated outputs.
- Keep reusable assets here. Keep client/project-specific code elsewhere.
