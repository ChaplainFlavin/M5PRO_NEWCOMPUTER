# Seedance Video Prompt

帮助用户为即梦 Seedance 2.0 生成高质量视频提示词。

## 功能特点

- 支持多模态输入（图片、视频、音频、文本）
- @ 语法精确控制素材用途
- 人物一致性保持方案
- 电影级运镜描述
- 15+ 行业提示词模板
- 负向提示词优化

## 安装

将 `seedance-video-prompt` 文件夹放入项目的 `.claude/skills/` 目录下：

```
your-project/
└── .claude/
    └── skills/
        └── seedance-video-prompt/
            ├── README.md
            └── SKILL.md
```

## 使用方法

在 Claude Code 中提及以下关键词即可自动激活：

- "视频提示词" / "视频prompt" / "Seedance" / "即梦"
- "生成视频" / "文生视频" / "图生视频"
- "AI视频" / "帮我写个视频"

### 示例

```
帮我写一个产品展示的视频提示词，要360度旋转展示
```

## 关于 Seedance 2.0

Seedance 2.0 是字节跳动推出的多模态视频生成模型：

- 单次最多 12 个文件输入
- 生成 4-15 秒视频
- 支持图片、视频、音频、文本混合输入

## 文件说明

| 文件 | 说明 |
|------|------|
| `SKILL.md` | 完整的提示词指南和模板库 |
| `README.md` | 本说明文件 |
