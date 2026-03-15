# File Organizer

自动整理项目文件的工具，将散落的文件归类到规范的目录结构中。

## 快速使用

在 Claude Code 中直接说：
- "帮我整理文件"
- "归类一下项目"
- "整理项目目录"

## 手动运行

```powershell
# 正常运行
powershell -ExecutionPolicy Bypass -File "organize_files.ps1"

# 预览模式（不移动文件）
powershell -ExecutionPolicy Bypass -File "organize_files.ps1" -DryRun

# 指定目录
powershell -ExecutionPolicy Bypass -File "organize_files.ps1" -RootDir "D:\your\project"
```

## 目录结构

```
CLAUDE/
├── projects/
│   ├── mcn-lark-bot/          # MCN智能中台
│   │   ├── src/               # Python源码
│   │   ├── docs/              # 文档
│   │   └── scripts/           # 脚本
│   ├── photography-studio/    # 摄影棚方案
│   │   ├── design-plans/      # 设计文档
│   │   └── discussions/       # 讨论记录
│   ├── cli-popup-fix/         # CLI弹窗修复
│   │   ├── scripts/           # 修复脚本
│   │   └── docs/              # 文档
│   └── content-extractor/     # 内容提取工具
│       └── src/               # 源码
├── workspace/                 # 临时文件
├── _ARCHIVE/                  # 归档文件
└── .claude/                   # Claude配置和技能
```

## 文件归类规则

| 文件类型 | 目标目录 |
|---------|---------|
| server.py, config.py 等 MCN 相关 | `projects/mcn-lark-bot/src/` |
| MCN 文档 (*.md) | `projects/mcn-lark-bot/docs/` |
| 摄影棚设计文档 | `projects/photography-studio/design-plans/` |
| CLI 弹窗修复脚本 | `projects/cli-popup-fix/scripts/` |
| 内容提取工具 | `projects/content-extractor/src/` |
| 临时文件 (bee, test.md 等) | `workspace/` |

## 自定义

编辑 `scripts/organize_files.ps1` 中的数组来添加新的归类规则：

```powershell
# 添加新的源文件
$mcnSrcFiles = @(
    "server.py",
    "your_new_file.py",  # 添加这里
    ...
)
```

## 注意事项

- 运行前建议先 `git commit` 保存重要更改
- 使用 `-DryRun` 预览确认后再正式运行
- 同名文件会被覆盖

## 参数说明

| 参数 | 说明 | 默认值 |
|-----|------|-------|
| `-RootDir` | 目标目录 | `D:\桌面NEW\AI练习\CLAUDE` |
| `-DryRun` | 预览模式，不实际移动文件 | `false` |

## 更新日志

- **2026-03** - 初始版本，从 `migrate_all.ps1` 迁移并优化
  - 添加 DryRun 模式
  - 添加自定义目录参数
  - 优化输出格式
