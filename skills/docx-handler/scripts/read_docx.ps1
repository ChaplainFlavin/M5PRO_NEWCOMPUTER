# read_docx.ps1
# 读取 docx 文件内容并保存为文本文件,方便 Claude 处理

param(
    [Parameter(Mandatory=$true)]
    [string]$DocxPath,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$UseWordCOM  # 如果安装了 Office,可以使用此选项获得更好的格式
)

function Read-DocxAsZip {
    param([string]$Path)
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        
        $zip = [System.IO.Compression.ZipFile]::OpenRead($Path)
        $documentEntry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
        
        if (-not $documentEntry) {
            throw "无法找到 document.xml,这可能不是有效的 docx 文件"
        }
        
        $stream = $documentEntry.Open()
        $reader = New-Object System.IO.StreamReader($stream)
        $xmlContent = $reader.ReadToEnd()
        $reader.Close()
        $stream.Close()
        $zip.Dispose()
        
        # 解析 XML 并提取文本
        [xml]$xml = $xmlContent
        $namespace = @{w='http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
        
        # 提取所有文本节点
        $textNodes = Select-Xml -Xml $xml -XPath "//w:t" -Namespace $namespace
        $text = ($textNodes | ForEach-Object { $_.Node.InnerText }) -join ""
        
        # 尝试添加段落分隔
        $paragraphs = Select-Xml -Xml $xml -XPath "//w:p" -Namespace $namespace
        $formattedText = ""
        foreach ($para in $paragraphs) {
            $paraText = ($para.Node.SelectNodes(".//w:t", $xml.DocumentElement.NamespaceManager) | ForEach-Object { $_.InnerText }) -join ""
            if ($paraText) {
                $formattedText += $paraText + "`n`n"
            }
        }
        
        return $formattedText.TrimEnd()
    }
    catch {
        Write-Error "ZIP 方法读取失败: $_"
        return $null
    }
}

function Read-DocxWithWord {
    param([string]$Path)
    
    try {
        $word = New-Object -ComObject Word.Application
        $word.Visible = $false
        
        $doc = $word.Documents.Open($Path)
        $text = $doc.Content.Text
        
        $doc.Close($false)
        $word.Quit()
        
        # 释放 COM 对象
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        
        return $text
    }
    catch {
        Write-Error "Word COM 方法读取失败: $_"
        return $null
    }
}

# 主逻辑
try {
    # 检查文件是否存在
    if (-not (Test-Path $DocxPath)) {
        Write-Error "文件不存在: $DocxPath"
        exit 1
    }
    
    # 获取绝对路径
    $DocxPath = Resolve-Path $DocxPath
    
    Write-Host "正在读取: $DocxPath" -ForegroundColor Cyan
    
    # 选择读取方法
    if ($UseWordCOM) {
        Write-Host "使用 Word COM 对象读取..." -ForegroundColor Yellow
        $content = Read-DocxWithWord -Path $DocxPath
    } else {
        Write-Host "使用 ZIP 解压方法读取..." -ForegroundColor Yellow
        $content = Read-DocxAsZip -Path $DocxPath
    }
    
    if (-not $content) {
        Write-Error "无法读取文件内容"
        exit 1
    }
    
    # 确定输出路径
    if (-not $OutputPath) {
        $OutputPath = [System.IO.Path]::ChangeExtension($DocxPath, ".txt")
    }
    
    # 保存为文本文件
    $content | Out-File -FilePath $OutputPath -Encoding UTF8
    
    Write-Host "`n✓ 成功!" -ForegroundColor Green
    Write-Host "  输出文件: $OutputPath" -ForegroundColor Green
    Write-Host "  字符数: $($content.Length)" -ForegroundColor Gray
    
    # 显示前 500 个字符预览
    Write-Host "`n--- 内容预览 (前 500 字符) ---" -ForegroundColor Cyan
    $preview = if ($content.Length -gt 500) { $content.Substring(0, 500) + "..." } else { $content }
    Write-Host $preview -ForegroundColor White
    
    return $OutputPath
}
catch {
    Write-Error "发生错误: $_"
    exit 1
}
