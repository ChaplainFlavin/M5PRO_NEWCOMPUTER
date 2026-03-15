# File Organizer - Project Migration Script
# Usage: powershell -ExecutionPolicy Bypass -File "organize_files.ps1" [-RootDir "path"]
# Description: Organizes scattered project files into a structured directory layout

param(
    [string]$RootDir = "D:\桌面NEW\AI练习\CLAUDE",
    [switch]$DryRun = $false
)

$ErrorActionPreference = "Continue"

function Show-Phase {
    param([string]$Title)
    Write-Host ""
    Write-Host "==> $Title" -ForegroundColor Cyan
}

function Move-FileSafely {
    param([string]$Source, [string]$Destination, [bool]$IsDryRun)

    if (-not (Test-Path $Source)) {
        return $false
    }

    if ($IsDryRun) {
        Write-Host "  [DRY-RUN] Would move: $Source -> $Destination" -ForegroundColor Yellow
        return $true
    }

    $destDir = Split-Path $Destination -Parent
    if (-not (Test-Path $destDir)) {
        [void](New-Item -ItemType Directory -Path $destDir -Force)
    }

    Move-Item -Path $Source -Destination $Destination -Force
    Write-Host "  MOVED: $(Split-Path $Source -Leaf) -> $destDir" -ForegroundColor Gray
    return $true
}

# ==================== START ====================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  FILE ORGANIZER" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "  [DRY-RUN MODE - No files will be moved]" -ForegroundColor Yellow
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Root: $RootDir" -ForegroundColor Gray

Set-Location $RootDir

# ==================== CREATE DIRECTORIES ====================
Show-Phase "Creating directory structure..."

$dirs = @(
    "projects\mcn-lark-bot\src",
    "projects\mcn-lark-bot\docs",
    "projects\mcn-lark-bot\scripts",
    "projects\mcn-lark-bot\tests",
    "projects\photography-studio\design-plans",
    "projects\photography-studio\design-plans\anfang",
    "projects\photography-studio\discussions",
    "projects\cli-popup-fix\scripts",
    "projects\cli-popup-fix\docs",
    "projects\content-extractor\src",
    "projects\content-extractor\tests",
    "workspace"
)

foreach ($dir in $dirs) {
    $targetPath = Join-Path $RootDir $dir
    if (-not (Test-Path $targetPath)) {
        if (-not $DryRun) {
            [void](New-Item -ItemType Directory -Path $targetPath -Force)
        }
        Write-Host "  CREATED: $dir" -ForegroundColor Green
    }
}

# ==================== MOVE MCN FILES ====================
Show-Phase "Moving MCN Lark Bot files..."

$mcnSrcFiles = @(
    "server.py", "config.py", "skill_router.py", "script_generator.py",
    "prompts.py", "card_templates.py", "file_handler.py",
    "smart_welcome.py", "base_sync.py", "setup_base.py",
    "explore_lark.py", "explore_dispatcher.py", "prompts_loader.py",
    "identity_manager.py", "profile_manager.py"
)

foreach ($file in $mcnSrcFiles) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\mcn-lark-bot\src\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

$mcnScriptFiles = @(
    "run_knowledge_collect.bat", "run_collect.py",
    "collect_knowledge.py", "create_bee_profile.py"
)

foreach ($file in $mcnScriptFiles) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\mcn-lark-bot\scripts\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

$mcnDocFiles = @(
    "MCN智能中台_实施计划.md",
    "MCN智能中台_Phase1完成纪要.md",
    "MCN智能中台_任务清单.md"
)

foreach ($file in $mcnDocFiles) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\mcn-lark-bot\docs\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

# ==================== MOVE PHOTOGRAPHY STUDIO FILES ====================
Show-Phase "Moving Photography Studio files..."

# From bee/bee/docs/plans
$beePlans = Join-Path $RootDir "bee\bee\docs\plans"
if (Test-Path $beePlans) {
    Get-ChildItem -Path $beePlans -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
        $dst = Join-Path $RootDir "projects\photography-studio\design-plans\$($_.Name)"
        Move-FileSafely -Source $_.FullName -Destination $dst -IsDryRun $DryRun
    }
}

# From bee/bee/anfang
$beeAnfang = Join-Path $RootDir "bee\bee\anfang"
if (Test-Path $beeAnfang) {
    $anfangDst = Join-Path $RootDir "projects\photography-studio\design-plans\anfang"
    Get-ChildItem -Path $beeAnfang -ErrorAction SilentlyContinue | ForEach-Object {
        $dst = Join-Path $anfangDst $_.Name
        Move-FileSafely -Source $_.FullName -Destination $dst -IsDryRun $DryRun
    }
}

# From 摄影棚方案讨论
$photoDiscuss = Join-Path $RootDir "摄影棚方案讨论"
if (Test-Path $photoDiscuss) {
    $discussDst = Join-Path $RootDir "projects\photography-studio\discussions"
    Get-ChildItem -Path $photoDiscuss -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        $dst = Join-Path $discussDst $_.Name
        Move-FileSafely -Source $_.FullName -Destination $dst -IsDryRun $DryRun
    }
}

# ==================== MOVE CLI POPUP FIX FILES ====================
Show-Phase "Moving CLI Popup Fix files..."

$cliScripts = @(
    "fix_cli_popups.ps1", "setup_no_popup_env.ps1", "diagnose_popup.ps1",
    "remove_bash_from_path.ps1", "create_fake_bash.ps1",
    "create_silent_fake_bash.ps1", "create_smart_fake_bash.ps1",
    "rebuild_interceptors.ps1", "monitor_process_creation.ps1",
    "toggle_real_git_bash.ps1", "check_locale.ps1"
)

foreach ($file in $cliScripts) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\cli-popup-fix\scripts\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

$cliDocs = @(
    "CLI弹窗修复说明.md",
    "空白弹窗问题完整解决方案.md",
    "静默拦截器解决方案_Walkthrough.md"
)

foreach ($file in $cliDocs) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\cli-popup-fix\docs\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

# ==================== MOVE CONTENT EXTRACTOR FILES ====================
Show-Phase "Moving Content Extractor files..."

$extractorFiles = @(
    "parse_html.py", "extract_text.py", "smart_extract.py",
    "extract_chinese_text.py", "simple_extract.py", "test_extract.py",
    "run_extract.py", "extract_content.ps1", "read_docx.ps1",
    "convert_md_to_docx.ps1", "run_extract.bat", "提取报告.md"
)

foreach ($file in $extractorFiles) {
    $src = Join-Path $RootDir $file
    $dst = Join-Path $RootDir "projects\content-extractor\src\$file"
    Move-FileSafely -Source $src -Destination $dst -IsDryRun $DryRun
}

# ==================== MOVE TEMP FILES ====================
Show-Phase "Moving temp files to workspace..."

$tempItems = @("bee", "test.md", "test2", "FatTian", "li", "123123", "debug_intercept.log")

foreach ($item in $tempItems) {
    $src = Join-Path $RootDir $item
    $dst = Join-Path $RootDir "workspace\$item"
    if (Test-Path $src) {
        if ($DryRun) {
            Write-Host "  [DRY-RUN] Would move: $item -> workspace/" -ForegroundColor Yellow
        } else {
            Move-Item -Path $src -Destination $dst -Force
            Write-Host "  MOVED: $item -> workspace/" -ForegroundColor Gray
        }
    }
}

# ==================== CLEANUP ====================
Show-Phase "Cleaning empty directories..."

$beeDir = Join-Path $RootDir "bee"
if ((Test-Path $beeDir) -and ((Get-ChildItem $beeDir -Recurse -ErrorAction SilentlyContinue).Count -eq 0)) {
    if ($DryRun) {
        Write-Host "  [DRY-RUN] Would remove: bee/" -ForegroundColor Yellow
    } else {
        Remove-Item -Path $beeDir -Force -Recurse
        Write-Host "  REMOVED: empty bee directory" -ForegroundColor Green
    }
}

# ==================== VERIFY ====================
Show-Phase "Verifying structure..."

$requiredDirs = @(
    "projects\mcn-lark-bot\src",
    "projects\mcn-lark-bot\docs",
    "projects\photography-studio\design-plans",
    "projects\cli-popup-fix\scripts",
    "projects\cli-popup-fix\docs",
    "projects\content-extractor\src",
    "workspace"
)

foreach ($dir in $requiredDirs) {
    $path = Join-Path $RootDir $dir
    if (Test-Path $path) {
        $count = @(Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue).Count
        Write-Host "  [OK] $dir ($count items)" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $dir" -ForegroundColor Red
    }
}

# ==================== COMPLETE ====================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "  DRY-RUN COMPLETE" -ForegroundColor Yellow
    Write-Host "  Run without -DryRun to apply changes" -ForegroundColor Yellow
} else {
    Write-Host "  ORGANIZATION COMPLETE" -ForegroundColor Green
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
