$ErrorActionPreference = "Stop"

$repoRoot = "D:\桌面NEW\AI练习\CLAUDE\ai-workbench"
$quickOpenRoot = "D:\AI_WORKBENCH_QUICKOPEN"

$filesToCopy = @(
    @{
        Source = Join-Path $repoRoot "README.md"
        Target = Join-Path $quickOpenRoot "README.md"
    },
    @{
        Source = Join-Path $repoRoot "NEW_MAC_RECOVERY_ORDER.md"
        Target = Join-Path $quickOpenRoot "NEW_MAC_RECOVERY_ORDER.md"
    },
    @{
        Source = Join-Path $repoRoot "TEXT_ARCHIVE_INDEX.md"
        Target = Join-Path $quickOpenRoot "TEXT_ARCHIVE_INDEX.md"
    },
    @{
        Source = Join-Path $repoRoot "IMPORT_MAP.md"
        Target = Join-Path $quickOpenRoot "IMPORT_MAP.md"
    },
    @{
        Source = Join-Path $repoRoot "bootstrap\NEW_MAC_DEPLOYMENT_CHECKLIST.md"
        Target = Join-Path $quickOpenRoot "NEW_MAC_DEPLOYMENT_CHECKLIST.md"
    }
)

$dirsToCopy = @(
    @{
        Source = Join-Path $repoRoot "prompts\mv-jimeng-seedance"
        Target = Join-Path $quickOpenRoot "prompts\mv-jimeng-seedance"
    },
    @{
        Source = Join-Path $repoRoot "prompts\wure-mv"
        Target = Join-Path $quickOpenRoot "prompts\wure-mv"
    },
    @{
        Source = Join-Path $repoRoot "memory\active"
        Target = Join-Path $quickOpenRoot "memory\active"
    }
)

New-Item -ItemType Directory -Path $quickOpenRoot -Force | Out-Null

foreach ($item in $filesToCopy) {
    if (Test-Path $item.Source) {
        $targetDir = Split-Path -Parent $item.Target
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        Copy-Item $item.Source -Destination $item.Target -Force
    }
}

foreach ($item in $dirsToCopy) {
    if (Test-Path $item.Target) {
        Remove-Item $item.Target -Recurse -Force
    }
    if (Test-Path $item.Source) {
        $targetParent = Split-Path -Parent $item.Target
        New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
        Copy-Item $item.Source -Destination $targetParent -Recurse -Force
    }
}

$indexPath = Join-Path $quickOpenRoot "QUICKOPEN_INDEX.md"
$lines = @(
    '# Quick Open Index',
    '',
    'This directory mirrors the most important `ai-workbench` docs and prompt archives.',
    '',
    '## Top-Level Docs',
    '',
    '- `NEW_MAC_DEPLOYMENT_CHECKLIST.md`',
    '- `NEW_MAC_RECOVERY_ORDER.md`',
    '- `TEXT_ARCHIVE_INDEX.md`',
    '- `IMPORT_MAP.md`',
    '- `README.md`',
    '',
    '## Prompt Archives',
    '',
    '- `prompts/mv-jimeng-seedance/`',
    '- `prompts/wure-mv/`',
    '',
    '## Active Memory',
    '',
    '- `memory/active/`'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllLines($indexPath, $lines, $utf8NoBom)

Write-Output "Quick open sync complete: $quickOpenRoot"
