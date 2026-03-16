# Text Archive Index

This file records the text archives copied into `ai-workbench` for new Mac recovery.

## Included for immediate recovery

### Prompt project archive

Location:

- `prompts/mv-jimeng-seedance/`

Contents:

- MV / Jimeng / Seedance workflow notes
- prompt exports
- prompt refinement iterations
- role and image prompt notes

### Wure MV local archive

Location:

- `prompts/wure-mv/20260313/`

Contents:

- early analysis archive
- second-round optimization record
- scattered-shot prompt archive

### Active working memory

Location:

- `memory/active/`

Contents:

- current memory snapshot
- "continue tomorrow" notes

### Project text archives

Location:

- `docs/project-archives/`

Included projects:

- `照亮太阳的心_审查与优化/`
- `摄影棚方案讨论/`
- `线下直播专线转播SOP/`
- `家具厂品控系统/`
- `纸箱厂订单管理系统/`

### Reference templates

Location:

- `docs/reference-templates/copyright/`

Contents:

- copyright and authorization text templates

### Environment assets

Location:

- `agent/`
- `skills/`
- `workflows/`

Contents:

- agent rules and context files from `.agent/`
- active custom skills from `.claude/skills/`
- workflow docs from `.agents/workflows/`

## Not included

These were intentionally not copied:

- local auth state
- caches and virtual environments
- zip backups
- image-only folders
- generated PDFs and binary outputs
- temp text dumps such as `tmp_all_docs.txt` and `tmp_script.txt`

## Recovery use

On the new Mac:

1. clone `ai-workbench`
2. open `NEW_MAC_RECOVERY_ORDER.md`
3. use `skills/`, `workflows/`, `prompts/`, and `memory/` first
4. refer to `docs/project-archives/` when resuming project context
