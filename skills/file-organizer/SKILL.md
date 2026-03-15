---
name: File Organizer
description: Organize and migrate project files into a structured directory layout
---

# File Organizer Skill

This skill organizes scattered project files into a clean, structured directory layout.

## When to Use This Skill

You MUST use this skill when:

- The USER wants to organize or tidy up project files
- The USER mentions "organize files", "migrate files", "整理文件", "归类"
- The USER wants to restructure their project directory
- Files are scattered and need to be sorted into proper folders

## How to Use This Skill

### Step 1: Confirm the Target Directory

Ask the USER which directory they want to organize, or use the default:
```
D:\桌面NEW\AI练习\CLAUDE
```

### Step 2: Run the Migration Script

Use the Bash tool to execute the PowerShell script:

```powershell
powershell -ExecutionPolicy Bypass -File "D:\桌面NEW\AI练习\CLAUDE\.claude\skills\file-organizer\scripts\organize_files.ps1"
```

### Step 3: Review Results

The script will output what files were moved and verify the structure.

## Directory Structure

The script organizes files into:

```
CLAUDE/
├── projects/
│   ├── mcn-lark-bot/          # MCN智能中台
│   │   ├── src/               # Python source files
│   │   ├── docs/              # Documentation
│   │   └── scripts/           # Utility scripts
│   ├── photography-studio/    # 摄影棚方案
│   │   ├── design-plans/      # 设计文档
│   │   └── discussions/       # 讨论记录
│   ├── cli-popup-fix/         # CLI弹窗修复
│   │   ├── scripts/           # Fix scripts
│   │   └── docs/              # Documentation
│   └── content-extractor/     # 内容提取工具
│       └── src/               # Source files
├── workspace/                 # Temporary files
├── _ARCHIVE/                  # Archived files
└── .claude/                   # Claude settings & skills
```

## Examples

### Example 1: Basic Usage

```
USER: 帮我整理一下项目文件

ASSISTANT: [Runs the organize_files.ps1 script]
ASSISTANT: 整理完成！文件已归类到以下目录...
```

### Example 2: After Adding New Files

```
USER: 我下载了一些新文件，帮我归类一下

ASSISTANT: [Runs the migration script]
ASSISTANT: 已将文件移动到对应的项目目录
```

## Customization

To customize the file organization rules, edit the script at:
```
.claude/skills/file-organizer/scripts/organize_files.ps1
```

You can modify:
- Target directory paths
- File patterns to match
- New project categories

## Safety Notes

- The script uses `Move-Item -Force`, so existing files will be overwritten
- Always commit important changes to git before running
- Review the script output for any errors

## Notes for Claude

- **Always confirm** with the user before running (files will be moved)
- **Check git status** first if the directory is a git repo
- **Safe to auto-run** after user confirmation
