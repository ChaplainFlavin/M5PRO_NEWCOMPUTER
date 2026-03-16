# New Project Workflow (/new_project)

## Description
This workflow automates the initialization of a new project folder, ensuring that standard structural elements like the `CHANGELOG.md` are present. This prevents context loss and establishes a forced documentation habit for any new endeavor (scripting, video prompts, research, etc.).

## Steps

### 1. Request Project Name
The AI must first ask the user for the name/topic of the new project (e.g., "Video Prompts v2", "Data Analysis Script").

### 2. Create Initialization Script
The AI will create a Python script in the `/tmp` directory that handles the directory and file creation.

```python
import os
import sys
from datetime import datetime

def initialize_project(project_name, base_dir):
    # Create valid directory name
    dir_name = "".join(c for c in project_name if c.isalnum() or c in (' ', '_', '-')).strip().replace(' ', '_')
    project_path = os.path.join(base_dir, dir_name)
    
    if os.path.exists(project_path):
        print(f"Error: Directory '{project_path}' already exists.")
        sys.exit(1)
        
    os.makedirs(project_path)
    
    # Create CHANGELOG.md
    changelog_path = os.path.join(project_path, "CHANGELOG.md")
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    changelog_content = f"""# {project_name} - Changelog

## 📝 核心目标与初始约束 (Core Objectives & Constraints)
- **项目目标**: [TODO: AI 需在此处总结立项时的核心目标]
- **前置设定**: [TODO: AI 需在此处记录用户首轮对话中提供的关键上下文/工具/约束条件]

---

## 📅 更新日志 (Update History)

### {current_time} - 项目初始化
- 创建项目文件夹 `{dir_name}`
- 初始化 `CHANGELOG.md` 建立上下文锚点
"""
    with open(changelog_path, 'w', encoding='utf-8') as f:
        f.write(changelog_content)
        
    print(f"Successfully created project '{project_name}' at '{project_path}'")
    print(f"Initialized '{changelog_path}'")
    
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python init_project.py <project_name> <base_dir>")
        sys.exit(1)
    
    initialize_project(sys.argv[1], sys.argv[2])
```

// turbo
### 3. Execute Initialization
The AI must run the generated python script using the `run_command` tool, passing the user-provided project name and the current base directory (e.g., `d:\桌面NEW\AI练习\CLAUDE`).

### 4. Populate Initial Context
After the script runs, the AI MUST immediately read the generated `CHANGELOG.md` and use the `replace_file_content` tool to fill out the `[TODO]` sections under "Core Objectives & Constraints" based on the very first instructions the user provided when starting the project.

### 5. Final Confirmation
Confirm to the user that the project space is ready and the context anchor is locked.
