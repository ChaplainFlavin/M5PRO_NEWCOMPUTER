---
name: Session Checkpoint
description: 自动保存和恢复工作进度，支持跨模型、跨项目无缝切换
---

# Session Checkpoint Skill

This skill helps save and restore work progress across sessions and projects.

## When to Use This Skill

You MUST use this skill when the USER says:

- "checkpoint" / "保存进度" / "保存"
- "resume" / "恢复进度" / "恢复"
- "status" / "查看状态" / "当前状态"
- Or asks to save/restore their work

## How to Use This Skill

### Action 1: Save Checkpoint (/checkpoint)

When the user wants to save progress:

1. **Get project name**: Use current directory name (e.g., "CLAUDE")
2. **Get task list**: Call `TaskList` to get all tasks
3. **Get current directory**: Read git status or recent files
4. **Create checkpoint JSON**:
   ```json
   {
     "project": "项目名",
     "saved_at": "ISO时间戳",
     "directory": "完整路径",
     "tasks": {
       "completed": [任务列表],
       "in_progress": [任务列表],
       "pending": [任务列表]
     },
     "summary": "用户最近做的事情摘要"
     }
   ```
5. **Save to file**: Write to `.claude/checkpoints/{项目名}-checkpoint.json`
6. **Report to user**: "✅ 已保存到 {文件名}"

### Action 2: Restore Checkpoint (/resume)

When the user wants to restore progress:

1. **Detect project**: Get current directory name
2. **Read checkpoint**: Read from `.claude/checkpoints/{项目名}-checkpoint.json`
3. **If file exists**:
   - Display saved time
   - Show completed tasks
   - Show in-progress tasks
   - Show summary of last work
   - Suggest next steps
4. **If file doesn't exist**: "未找到进度文件，这是新项目或尚未保存过"
5. **Optional restore tasks**: Ask if user wants to restore tasks to TaskList

### Action 3: Switch Project (/resume [项目名])

When user says "resume [项目名]" or "切换到 [项目名]":

1. **List available projects**: Read all files in `.claude/checkpoints/`
2. **Search for match**: Find `{项目名}-checkpoint.json`
3. **If found**:
   - Display project info (tasks, summary, last save time)
   - Warn: "⚠️ 当前目录是 [当前项目]，要切换到 [目标项目] 的进度吗？"
   - If user confirms: Load and display that project's checkpoint
4. **If not found**: "未找到项目 [项目名] 的 checkpoint"
5. **Available projects**: List all `{*}-checkpoint.json` files

### Action 4: Show Status (/status)

When the user wants to see current status:

1. **Get current state**: Call TaskList
2. **Get checkpoint info**: Check if checkpoint file exists
3. **Display summary**:
   - Current project
   - Tasks (completed/in progress/pending)
   - Last save time (if available)
   - Current directory

## Examples

### Example 1: Save Progress
```
USER: checkpoint
或
USER: 保存进度

ASSISTANT:
[调用 TaskList 获取任务]
[获取当前目录信息]
[创建 checkpoint JSON]
[保存到文件]

✅ 已保存到 CLAUDE-checkpoint.json
- 进行中任务: 1 个
- 待办任务: 2 个
- 保存时间: 2025-01-15 14:30:00
```

### Example 2: Restore Progress
```
USER: resume
或
USER: 恢复进度

ASSISTANT:
[读取 checkpoint 文件]
[显示摘要]

📂 恢复工作进度...
项目: CLAUDE
上次保存: 2小时前

已完成任务:
  ✅ 修复登录 bug

进行中任务:
  🔄 实现用户注册功能

待办任务:
  📋 添加单元测试
  📋 编写文档

最近工作: 正在实现用户注册功能，已完成表单验证

下一步建议:
  1. 继续完成注册功能的后端 API
  2. 添加错误处理

是否需要将这些任务恢复到任务列表? (y/n)
```

### Example 3: Show Status
```
USER: status
或
USER: 查看状态

ASSISTANT:
[调用 TaskList]
[检查 checkpoint 文件]

📊 当前项目状态
项目: CLAUDE
目录: D:\桌面NEW\AI练习\CLAUDE
Git状态: clean (无未提交更改)

任务:
  ✅ 已完成: 2 个
  🔄 进行中: 1 个
  📋 待办: 2 个

上次保存: 2小时前
```

### Example 4: Switch Project
```
USER: resume 电商网站
或
USER: 切换到 电商网站

ASSISTANT:
[列出 checkpoints 目录下的所有文件]
[查找 电商网站-checkpoint.json]

📂 找到项目: 电商网站
上次保存: 3天前

已完成:
  ✅ 完成登录功能
  ✅ 添加购物车

进行中:
  🔄 支付接口对接

待办:
  📋 订单管理
  📋 优惠券系统

⚠️ 当前目录是 CLAUDE，是否切换查看 电商网站 项目的进度?

USER: yes

ASSISTANT:
已加载 电商网站 项目进度。
[显示完整状态...]
```

## Checkpoint File Location

```
.claude/checkpoints/
├── CLAUDE-checkpoint.json
├── other-project-checkpoint.json
└── ...
```

## Important Notes

- **Always use absolute paths** when reading/writing checkpoint files
- **Create checkpoints directory** if it doesn't exist
- **Project name** is derived from current directory name
- **Tasks are prioritized** - always sync with TaskList first
- **Cross-model compatible** - JSON format works with any AI model
- **Incremental updates** - each save overwrites the previous checkpoint (not append) -> **CRITICAL REVISION**: You MUST read the existing checkpoint file first (if it exists) and **APPEND** new items to the arrays (`tasks.completed`, `logs`, etc.). **NEVER OVERWRITE OR DELETE EXISTING LOGS/TASKS**.
- **APPAND ONLY CONSTRAINT**: When saving a checkpoint, you are strictly forbidden from wiping out the previous history. You must load the JSON, insert your new logs/status at the end of the arrays, and rewrite the combined JSON.

## Error Handling

If checkpoint operations fail:

1. **File not found**: Inform user this is a new project
2. **Permission denied**: Check directory permissions
3. **Invalid JSON**: File may be corrupted, offer to recreate
4. **Directory missing**: Create `.claude/checkpoints/` automatically

## 工作流程

### 1. 保存进度 (/checkpoint)

**⚠️【绝对约束：只能新增，严禁删改历史】⚠️**
1. **检测文件**：必须先检测并读取由于之前已存在的 `{项目名}-checkpoint.json`。
2. **合并数据**：将本次的 TaskList 最新状态**合并/追加**进现有的 JSON 数组中，**严禁将原来的历史数据清空！**
3. **追加日志**：将本次工作产生的 `logs` 和最新进展，**追加（Append）**到现有的 `logs` 数组末尾。
4. **保存写入**：将完整合并后的 JSON 重新写入文件。

### 2. 恢复进度 (/resume)

1. **检测项目**：获取当前目录名
2. **读取文件**：加载对应的 checkpoint 文件
3. **显示摘要**：
   - 上次工作时间
   - 已完成的任务
   - 进行中的任务
   - 最近的工作日志（关键决策、bug、尝试的方案）
   - 建议的下一步

### 3. 切换项目 (/resume [项目名])

1. **读取指定**：加载指定项目的 checkpoint
2. **显示状态**：同上

## Checkpoint 文件结构

```json
{
  "project": "项目名称",
  "created_at": "2025-01-15T10:00:00",
  "last_updated": "2025-01-15T14:30:00",
  "model_history": ["gemini", "claude", "gemini"],
  "tasks": {
    "completed": ["任务1", "任务2"],
    "in_progress": ["任务3"],
    "pending": ["任务4"]
  },
  "modified_files": ["src/auth.js", "styles/main.css"],
  "logs": [
    {
      "time": "2025-01-15T10:00:00",
      "model": "claude",
      "type": "decision",
      "content": "决定使用 JWT 进行身份验证"
    },
    {
      "time": "2025-01-15T10:30:00",
      "model": "gemini",
      "type": "bug",
      "content": "发现 token 验证失败，错误：Cannot read property 'token'"
    },
    {
      "time": "2025-01-15T11:00:00",
      "model": "claude",
      "type": "solution",
      "content": "修复方案：在 async function 中添加 await"
    }
  ],
  "context": {
    "current_work": "正在修复登录功能的 token 验证问题",
    "next_steps": ["添加单元测试", "处理登出逻辑"],
    "notes": "token 存储在 localStorage，key 为 'auth_token'"
  }
}
```

## 日志类型

- `decision`: 重要决策（技术选型、方案设计）
- `code`: 代码变更（新增功能、重构）
- `bug`: Bug 报告（错误信息、堆栈）
- `solution`: 解决方案（修复方法、验证结果）
- `progress`: 进度更新（任务完成、里程碑）

## 重要提示

1. **增量追加**：每次保存都是追加，不覆盖历史
2. **项目隔离**：不同项目的 checkpoint 互不影响
3. **跨模型兼容**：JSON 格式，任何模型都能读取
4. **TaskList 同步**：优先使用 TaskList，checkpoint 作为补充

## 用户友好特性

- 切换项目时自动检测目录
- 如果检测到目录与 checkpoint 不匹配，提示用户
- 支持显式指定项目名切换
- 日志太多时自动摘要（只保留最近的 N 条）
