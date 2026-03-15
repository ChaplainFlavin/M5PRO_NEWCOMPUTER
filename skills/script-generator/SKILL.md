---
name: Script Generator
description: Generate Xiaohongshu/YouTube video scripts based on specific templates (Tech Tweaks, Buying Guide, Product List, Sponsored), with image search and docx capabilities.
---

# Script Generator Skill

This skill helps the user generate video scripts for Xiaohongshu/YouTube based on 4 defined categories, and includes workflows for image handling and document conversion.

## Triggering the Skill

The user can trigger this skill by using keywords like:

- "生成文案" (Generate script)
- "写个脚本" (Write a script)
- "文案生成" (Script generation)
- "帮我写个..." (Help me write a...)
- "配图" (Add images)

## Categories

1. **Tech Tweaks (干货技巧类)**: Tips, hidden features, tutorials.
2. **Buying Guide (选购攻略类)**: How to choose between products, updated parameter comparison.
3. **Product List (好物清单类)**: Recommendations of multiple products.
4. **Sponsored (单品推广/商单类)**: In-depth review of a single product with brand cooperation features.

## Workflows

### 1. Script Generation

1. **Identify the Category**: Determine which of the 4 categories fits the user's request.
2. **Check for Required Info**: Ensure the user has provided the necessary details.
3. **Generate Script**: Use the templates below to generate the markdown content, including `> **【📸 配图任务】**` placeholders.

### 2. Image Sourcing (Batch Process) - IMPORTANT

When the user asks to "search for images" or "add images":

1. **Analyze Requirements**: Scan the markdown file for all `> **【📸 配图任务】**` blocks.
2. **Batch Search**:
   - Create **ONE** `browser_subagent` task.
   - In that single task, instruct the subagent to find direct image URLs for **ALL** required images at once.
   - The subagent should return a list of all URLs found.
3. **Batch Download & Insert**:
   - Run `Invoke-WebRequest` commands to download all images to an `./images` folder.
   - Use **ONE** `multi_replace_file_content` call to insert all images into the markdown file at once.
   - **DO NOT** ask for confirmation for each individual image.

### 3. Export to Word

1. **Convert**: Use the `convert_md_to_docx.ps1` script to convert the final markdown with images to a `.docx` file.
   - Command: `python <script_path> <input_md> <output_docx>` (or PowerShell equivalent if using the PS version).

## Templates

### 1. 干货技巧类 (Tech Tweaks)

**结构：**

1. **[痛点/钩子]**: 别再只用[设备名]做[基础功能]了！这[数字]个隐藏功能，很多人都不知道...
2. **[技巧清单]**:
   - 技巧 1: 操作 + 好处
   - 技巧 2: 操作 + 好处
   - ...
3. **[结尾/CTA]**: 学会这招，再也不用... 赶紧去试试吧！

### 2. 选购攻略类 (Buying Guide)

**结构：**

1. **[选购难题]**: [产品A]和[产品B]到底怎么选？
2. **[核心参数标准]**:
   - 标准 1: [推荐标准] 优于 [淘汰标准]
   - 标准 2: 建议选择 [数值] 以上
   - ...
3. **[产品推荐]**:
   - 推荐 1: 适合[人群]，优势[卖点]
   - 推荐 2: 适合[人群]，优势[卖点]
4. **[总结建议]**: 看重性价比选A，追求体验选B。

### 3. 好物清单类 (Product List)

**结构：**

1. **[场景/人群设定]**: 预算[金额]以内的[产品类型]天花板！
2. **[好物快速盘点]**:
   - 好物 1: [产品名] —— 核心卖点(一句话)
   - 好物 2: [产品名] —— 核心卖点(一句话)
   - ...
3. **[互动引导]**: 你最想拥有哪一个？评论区告诉我！

### 4. 单品推广/商单类 (Sponsored)

**结构：**

1. **[背景/痛点引入]**: 最近很多粉丝问我[某类产品]怎么选？市面上的[痛点]让人头大...
2. **[产品登场]**: 今天终于被我挖到了这款全能选手——[产品名]...
3. **[核心卖点/实测]**:
   - 卖点 1 (核心优势): 场景/测试 + 结果
   - 卖点 2 (针对特定人群): 场景/测试 + 结果
   - 卖点 3 (黑科技): 场景/测试 + 结果
4. **[信任保障/福利]**: 隐私安全/只换不修/首发赠送...
5. **[强力推荐/CTA]**: 这么全能的[产品]，真的不冲吗？链接就在...

## Examples

**User**: "帮我写个iPhone省电技巧的文案"
**Claude**: [Identifies "Tech Tweaks". Generates script with text.]

**User**: "给这个文案配图"
**Claude**: [Identifies "Image Sourcing". batches all image searches, downloads them, and updates the file.]
