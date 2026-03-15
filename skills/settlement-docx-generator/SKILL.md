---
name: settlement-docx-generator
description: Generate settlement-sheet Word documents from a fixed set of project fields and existing company templates. Use when the user asks to 出结算单、生成结算单、填写结算单、按模板输出结算单 Word、根据项目金额和时间出结算单，or when Codex needs to collect key billing fields, choose the right settlement template family, and produce a printable `.docx` file.
---

# Settlement Docx Generator

Use the existing settlement project in `D:\桌面NEW\AI练习\CLAUDE\结算单汇总`.

## Workflow

1. Identify whether the request is to create a new settlement document, update an existing one, or classify a new template.
2. Read only the files needed:
   - Use `template_registry.json` for registered templates.
   - Use [references/input-schema.md](references/input-schema.md) for the fixed intake format and template-family mapping.
   - Read additional `.docx` templates only when the user provides a new template that is not yet classified.
3. Collect the minimum missing fields. Ask concise follow-up questions only for fields required by the selected template family.
4. Prefer the fixed input schema from the reference file, even if the user describes the request in free text.
5. Treat images, screenshot pages, and delivery-link attachments as optional. Do not block document generation on those fields unless the user explicitly requires them.
6. Generate the document through the workspace script:
   - Single-item/simple cases: pass fields directly or write a minimal JSON file under `2_InputData/`.
   - Multi-item cases: write a JSON file under `2_InputData/` and run `automation_engine.py --data ...`.
7. Save the final `.docx` into `3_Outputs/` unless the user asks for another path.
8. Report the output path and summarize any assumptions made.

## Operating Rules

- Default to the smallest number of questions needed to generate a valid document.
- Keep the intake stable across template families. Map the shared input fields into each template instead of inventing a new schema per document.
- Separate `project_date` from `issue_date` when both exist.
- If the total amount is provided but line items are not, generate a single default item.
- If a template is not yet in `template_registry.json`, classify it before generating from it.
- Do not spend time on embedded images unless the user explicitly asks to automate them.

## Commands

Use these commands from the workspace root or the settlement project directory.

```powershell
py -3.12 .\automation_engine.py --data .\2_InputData\sample_zhian_live.json
```

```powershell
py -3.12 .\automation_engine.py --template zhian_general_live --interactive
```

## Template Expansion

When the user provides a new settlement template:

1. Compare it against the known families in [references/input-schema.md](references/input-schema.md).
2. Reuse an existing family when only the visual style changes.
3. Add a new family only when the required text fields genuinely differ.
4. Register the new template in `template_registry.json`.
5. Update the input-schema reference if the fixed intake format changes.
