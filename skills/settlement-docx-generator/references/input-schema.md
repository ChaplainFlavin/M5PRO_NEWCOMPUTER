# Input Schema

Use this file when generating or extending settlement-sheet templates in `D:\桌面NEW\AI练习\CLAUDE\结算单汇总`.

## Fixed Intake Fields

Prefer this stable input shape:

```json
{
  "template_family": "standard_full",
  "template_id": "",
  "client_name": "",
  "project_name": "",
  "project_date": "",
  "issue_date": "",
  "project_location": "",
  "project_format": "",
  "project_content": "",
  "items": [
    {
      "name": "",
      "desc": "",
      "spec": "",
      "unit": "",
      "num": "",
      "price": "",
      "amount": "",
      "note": ""
    }
  ],
  "total_amount": "",
  "remarks": [
    "我方已完成交付，贵方已验收完毕，我方已开具发票，现向贵方申请支付款项。"
  ],
  "attachments": {
    "title": "",
    "link_url": "",
    "link_code": ""
  }
}
```

## Required Fields By Situation

### Always required

- `client_name`
- `project_name`
- `project_date`
- `project_content` or a line-item description that makes the project clear
- `total_amount` or enough `items` data to calculate it

### Usually required for full templates

- `project_format`
- `issue_date`

### Optional

- `project_location`
- `remarks`
- `attachments`
- all image-related content

## Template Families

### `standard_full`

Use for templates shaped like:

- `交行结算单-0822.docx`
- `质安结算单-知识产权直播录播课件制作-1225.docx`

Characteristics:

- top information block includes service object, project name, date, format, content
- detail table includes project, content, spec, unit, quantity, price, amount
- attachments may exist below the remarks

### `simple_detail`

Use for templates shaped like:

- `【结算单】2025佛山市安排工作退役士兵适应性培训班 - 副本.docx`
- `【结算单】丹寨县2025新型工业化促乡村振兴专题培训班.docx`

Characteristics:

- top information block usually includes only service object and project name
- detail table is simpler: item name, quantity, unit price, note, amount
- screenshots and delivery links are commonly pasted manually

## Intake Guidance

- If the user gives only one total amount, create one default line item.
- If the user provides multiple services, keep each service as one line item.
- If the user does not mention a template family, infer it from the target template or ask one concise follow-up question.
- Do not ask about attachments unless the target template actually uses them.
