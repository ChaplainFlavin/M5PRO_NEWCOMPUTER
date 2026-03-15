# New Mac Deployment Checklist

目标：新 Mac 到手后，最快恢复可工作的 AI + 内容生产环境。

适用场景：

- 外地拿到新电脑
- 需要第一时间续上现有工作
- 重点恢复 Antigravity、Codex、`ai-workbench`、项目仓库、视频资料

## 一、出发前准备

这些内容最好在旧电脑上先准备好。

### 账号和登录

- Apple ID
- Google 账号
- GitHub
- 微信
- 飞书
- 百度网盘
- LETS VPN
- 迅雷
- 剪映
- Steam

### 必须确认

- 密码管理器可正常使用
- GitHub SSH 已配置
- 2FA 可正常接收
- `ai-workbench` 已推到 GitHub
- 正在做的项目仓库已推到 GitHub
- 关键 `.env` 和 API key 已脱敏整理

### 提前下载或记录

- LETS VPN for Mac 安装包
- 剪映 Mac 版安装包
- 微信 Mac 版安装包
- 飞书 Mac 版安装包
- 百度网盘 Mac 版安装包
- 迅雷 Mac 版安装包
- Steam Mac 版安装包

## 二、新机首日安装顺序

按这个顺序最稳。

### Phase 1：先保证网络和登录

1. 登录 Apple ID
2. 连接网络
3. 安装 LETS VPN
4. 登录 Google
5. 登录密码管理器
6. 登录 GitHub

### Phase 2：装基础工作底座

1. 安装 Chrome
2. 登录主工作浏览器 Profile
3. 安装 Git
4. 检查 SSH
5. 安装终端基础环境

### Phase 3：装核心 AI 工具

1. 安装 Antigravity
2. 安装 Codex
3. 登录相关账号
4. clone `ai-workbench`
5. 打开：
   - `NEW_MAC_RECOVERY_ORDER.md`
   - `TEXT_ARCHIVE_INDEX.md`
   - 本文件

### Phase 4：恢复项目和资料

1. clone 正在做的业务项目
2. 恢复 `.env`
3. 安装百度网盘
4. 同步关键视频资料
5. 验证至少一个项目可继续工作

### Phase 5：装沟通和生产工具

1. 微信
2. 飞书
3. 闪电说
4. 剪映
5. 迅雷

### Phase 6：最后再装非关键项

1. Steam

## 三、必装软件清单

这些建议首日完成。

### 网络

- LETS VPN

### 浏览器和账号入口

- Google Chrome
- 密码管理器

### 开发和 AI

- Git
- Antigravity
- Codex

### 数据和同步

- 百度网盘

### 沟通

- 微信
- 飞书
- 闪电说

### 内容生产

- 剪映

## 四、可以当天晚些再装

- 迅雷
- Steam

## 五、恢复后要检查的关键点

### AI 工作环境

- `ai-workbench` 能正常 clone
- `skills/` 可访问
- `workflows/` 可访问
- `prompts/` 可访问
- `memory/` 可访问

### 项目续工

- 当前正在做的项目仓库能拉下来
- `.env` 能补齐
- 至少一个项目能跑通

### 资料同步

- 百度网盘关键目录开始同步
- 需要的本地视频素材能找到

### 沟通链路

- 微信可登录
- 飞书可登录
- 闪电说可用

## 六、建议同步的本地资料

除了代码和 `ai-workbench`，建议优先同步：

- 关键视频素材
- 当前项目的参考图
- 常用模板
- 常用导出文档
- 正在做的 MV 相关资料

## 七、你的最小成功标准

只要下面这些完成，就可以开始工作：

1. LETS VPN 可用
2. Chrome、Git、Antigravity、Codex 可用
3. `ai-workbench` 已 clone
4. 正在做的项目已 clone
5. 微信、飞书已登录
6. 百度网盘已开始同步关键资料
7. 剪映可正常打开

## 八、建议的仓库外清单

你还可以单独保留一个“安装包与账号清单”，内容包括：

- 软件名称
- 下载地址
- 是否必须首日安装
- 登录账号
- 备注

推荐标记方式：

- `P0`：首日必装
- `P1`：当天建议装
- `P2`：后装即可
