# New Mac Recovery Order

目标：在新 Mac 上尽快恢复可工作的 AI 环境，而不是一次性恢复所有旧机器状态。

适用场景：

- 新电脑到手后人在外地
- 需要尽快续上当前工作
- 重点是 Antigravity、Codex、skills、prompts、业务仓库

## Phase 1: 先恢复登录能力

先完成所有账号和身份验证，否则后面每一步都会卡住。

### 必做

1. 登录 Apple ID
2. 登录 Google 账号
3. 登录密码管理器
4. 登录 GitHub
5. 确认 2FA 可用

### 验收标准

- 能打开 GitHub 私有仓库
- 能拿到 API keys
- 能访问 Google 相关工作环境

## Phase 2: 装基础开发环境

先装底层工具，再装 AI 客户端。

### 必做

1. 安装 Xcode Command Line Tools
2. 安装 Homebrew
3. 安装 Git
4. 配置 SSH key
5. 测试 GitHub SSH 连接

### 建议补齐

- `gh`
- `uv`
- `python`
- `node`
- `pnpm`
- `jq`
- `fd`
- `ripgrep`

### 验收标准

- `git clone` 正常
- `ssh -T git@github.com` 正常
- `python --version`、`node --version` 正常

## Phase 3: 装核心 AI 工具

这里先装你真正会立刻用到的工具，不做无关扩展。

### 必做

1. 安装浏览器
2. 登录 Antigravity
3. 安装 Codex
4. 登录 Codex

### 你这次的原则

- 先保证能工作
- 不追求首日恢复所有边角配置
- 本地模型、额外实验工具放后面

### 验收标准

- Antigravity 可正常进入工作界面
- Codex 可正常访问本地目录和 Git 仓库

## Phase 4: 拉取 `ai-workbench`

这是恢复你个人 AI 工作台资产的关键步骤。

### 必做

1. `git clone` 你的 `ai-workbench` 私有仓库
2. 打开仓库根目录
3. 先看 `README.md`
4. 再看 `IMPORT_MAP.md`
5. 再看本文件

### 拉下来后重点确认

- `skills/`
- `workflows/`
- `prompts/`
- `memory/`
- `bootstrap/`

### 验收标准

- 你常用的 skill 文档都在
- 你常用的提示词都在
- 你知道“接下来该继续什么工作”

## Phase 5: 恢复业务项目

这一步才开始拉具体业务仓库。

### 建议顺序

1. 当前正在进行的项目
2. 今天或明天会继续的项目
3. 只做参考的老项目

### 每个项目都要检查

1. 仓库能拉下来
2. `README.md` 是否可用
3. `.env.example` 是否齐全
4. 依赖是否能安装
5. 项目是否能跑最小 smoke test

### 验收标准

- 至少一个正在做的项目能正常启动
- 你能继续当天的主要任务

## Phase 6: 恢复个人工作流

不是恢复旧机器全部状态，而是恢复“你怎么工作”。

### 必做

1. 把 `skills/` 中最常用的内容确认可访问
2. 把视频提示词、剧本提示词、版权说明模板确认可读
3. 打开 `memory/` 中的续工笔记
4. 按当前任务重新建立当天工作上下文

### 对你最关键的内容

- 写剧本相关 skill
- 视频提示词相关 skill
- 继续工作用的 memory/handoff 文档

### 验收标准

- 你能在新电脑上立即开始写、改、生成
- 不需要回旧电脑查关键文档

## Phase 7: 最后再补非关键项

这些内容可以延后，不影响首日开工。

- 本地模型
- Docker / 容器环境
- 大素材归档
- 历史项目整理
- 各种实验工具

## 首日最小成功标准

如果下面 5 条成立，就说明迁移成功：

1. 能登录 Antigravity
2. 能登录 Codex
3. 能 clone `ai-workbench`
4. 能打开你的 skills 和 prompts
5. 能跑起至少一个正在做的项目

## 推荐执行节奏

### 到手后前 30 分钟

- 登录账号
- 配 GitHub
- 安装基础工具

### 第 30 到 90 分钟

- 装 Antigravity
- 装 Codex
- clone `ai-workbench`

### 第 90 到 180 分钟

- clone 当前项目
- 补环境变量
- 跑最小测试
- 正式续工

## 不要做的事

- 不要整机照搬旧电脑缓存
- 不要把本地登录态和数据库直接同步进 Git
- 不要优先折腾非关键工具
- 不要第一天就整理所有历史文件

## 你的恢复顺序一句话版

先登录，后装底座；先装 Antigravity 和 Codex，再拉 `ai-workbench`；最后拉业务项目并开工。
