---
name: DOCX Handler
description: Read and extract content from Microsoft Word (.docx) files
---

# DOCX Handler Skill

This skill enables Claude to read and extract text content from Microsoft Word (.docx) files.

## When to Use This Skill

You MUST use this skill when:

- The USER asks you to read, view, or analyze a `.docx` file
- The USER provides a path to a `.docx` file and wants to know its contents
- The USER wants to extract text from a Word document
- You need to access content stored in a `.docx` file to complete a task

## How to Use This Skill

### Step 1: Identify the DOCX File

When the USER mentions a `.docx` file, note the file path. If they don't provide a full path, ask for it or search for the file.

### Step 2: Run the Extraction Script

Use the `run_command` tool to execute the PowerShell script:

```powershell
powershell -ExecutionPolicy Bypass -File "D:\桌面NEW\AI练习\CLAUDE\.claude\skills\docx-handler\scripts\read_docx.ps1" -DocxPath "PATH_TO_DOCX_FILE"
```

**Parameters:**

- `-DocxPath`: (Required) Full path to the `.docx` file
- `-OutputPath`: (Optional) Where to save the extracted text (defaults to same name with `.txt` extension)
- `-UseWordCOM`: (Optional) Use Word COM object if Office is installed (better formatting)

### Step 3: Read the Extracted Content

After the script runs successfully, it will create a `.txt` file. Use the `view_file` tool to read the extracted content.

### Step 4: Present to User

Show the content to the USER or use it to complete their request.

## Examples

### Example 1: Basic Usage

```
USER: Can you read this file: D:\Documents\report.docx

ASSISTANT: [Calls run_command with the extraction script]
ASSISTANT: [Calls view_file on the generated .txt file]
ASSISTANT: Here's the content from report.docx: [presents content]
```

### Example 2: With Custom Output Path

```
USER: Extract the text from contract.docx and save it as contract_text.txt

ASSISTANT: [Calls run_command with -OutputPath parameter]
ASSISTANT: I've extracted the content and saved it to contract_text.txt
```

### Example 3: Using Word COM for Better Formatting

```
USER: Read this docx file and preserve the formatting as much as possible

ASSISTANT: [Calls run_command with -UseWordCOM flag]
ASSISTANT: [Presents the extracted content]
```

## Technical Details

### How It Works

The script uses two methods to extract text:

1. **ZIP Method (Default)**:
   - Treats `.docx` as a ZIP archive
   - Extracts `word/document.xml`
   - Parses XML to get text content
   - No Office installation required

2. **Word COM Method** (with `-UseWordCOM` flag):
   - Uses Microsoft Word COM object
   - Requires Office installation
   - Better formatting preservation

### Output Format

- Extracted text is saved as UTF-8 encoded `.txt` file
- Paragraphs are separated by double newlines
- Original formatting (bold, italic, etc.) is not preserved in plain text

## Error Handling

If the script fails:

1. Check if the file path is correct and the file exists
2. Verify the file is a valid `.docx` file (not `.doc` or corrupted)
3. If using `-UseWordCOM`, ensure Microsoft Office is installed
4. Try the default ZIP method if COM method fails

## Limitations

- Does not preserve formatting (bold, italic, colors, etc.)
- Does not extract images or embedded objects
- Tables are extracted as plain text (structure may be lost)
- Headers and footers may not be included in ZIP method
- Only works with `.docx` format (not older `.doc` format)

## Notes for Claude

- **Always use absolute paths** when calling the script
- **Auto-run is safe** for this script (set `SafeToAutoRun: true`)
- **Check file existence** before running the script
- **Read the output** automatically and present it to the user
- If the USER just wants to "read" a docx, extract it and show the content directly
