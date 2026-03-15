# DOCX Handler Skill

This skill enables Claude to automatically read and extract content from Microsoft Word (.docx) files.

## Structure

```
docx-handler/
├── SKILL.md              # Main skill instructions for Claude
├── scripts/
│   └── read_docx.ps1     # PowerShell script to extract docx content
└── README.md             # This file
```

## Features

- **Automatic Detection**: Claude will automatically recognize when you ask to read a `.docx` file
- **Two Extraction Methods**:
  - ZIP method (default, no Office required)
  - Word COM method (requires Office, better formatting)
- **UTF-8 Output**: Extracted text is saved as UTF-8 encoded `.txt` files
- **Paragraph Preservation**: Maintains paragraph breaks in the extracted text

## Usage Examples

Once this skill is active, you can simply say:

- "Read this file: D:\Documents\report.docx"
- "What's in contract.docx?"
- "Extract text from presentation.docx"

Claude will automatically:

1. Run the extraction script
2. Read the extracted content
3. Present it to you

## Manual Usage

You can also run the script directly:

```powershell
# Basic usage
.\scripts\read_docx.ps1 -DocxPath "path\to\file.docx"

# With custom output path
.\scripts\read_docx.ps1 -DocxPath "file.docx" -OutputPath "output.txt"

# Using Word COM (requires Office)
.\scripts\read_docx.ps1 -DocxPath "file.docx" -UseWordCOM
```

## Requirements

- **Windows PowerShell** (built-in on Windows)
- **No Office required** for default ZIP method
- **Microsoft Office** required only for `-UseWordCOM` option

## Limitations

- Only supports `.docx` format (not older `.doc`)
- Does not preserve formatting (bold, italic, colors)
- Does not extract images or embedded objects
- Table structure may be lost in plain text conversion

## Troubleshooting

If extraction fails:

1. Verify the file is a valid `.docx` file
2. Check file path is correct
3. Ensure file is not corrupted
4. Try without `-UseWordCOM` if Office method fails

## Version

- **Version**: 1.0.0
- **Created**: 2026-02-10
- **Author**: Claude (Antigravity)
