---
name: formal-greeting-reply
description: Detect greeting-only or greeting-led user messages such as "你好", "您好", "hello", "hi", "早上好", "下午好", "晚上好", or similar casual salutations, run `scripts/match_greeting.py` to classify the greeting with regex, and return the specific formal enhanced greeting produced by the script. Use when a user opens with a greeting and the reply should be standardized, formal, and deterministic.
---

# Formal Greeting Reply

Use this skill for greeting-first messages. Do not improvise the greeting reply when this skill triggers. Execute the bundled script so the wording stays deterministic.

## Workflow

1. Run the greeting matcher with the raw user message:

```powershell
python "C:\Users\wsk\.codex\skills\formal-greeting-reply\scripts\match_greeting.py" --text "<user-message>"
```

2. Read the JSON returned by the script.
3. If `matched` is `true`, use `reply` exactly as the first sentence of the assistant response.
4. If `remaining_text` is empty, send only `reply`.
5. If `remaining_text` is not empty, send `reply` first and then continue handling `remaining_text` as the actual user request.
6. If `matched` is `false`, ignore this skill and continue with the normal workflow.

## Output Contract

The script prints a single JSON object:

```json
{
  "matched": true,
  "category": "morning",
  "reply": "您好，早上好。很高兴为您服务，请问有什么可以协助您？",
  "remaining_text": ""
}
```

Field meanings:

- `matched`: whether the input begins with a supported greeting.
- `category`: greeting type selected by the regex rules.
- `reply`: the exact formal greeting to send back.
- `remaining_text`: leftover user request after the greeting prefix is removed.

## Matching Rules

The script already handles:

- Chinese greetings such as `你好`, `您好`, `早上好`, `下午好`, `晚上好`, `晚安`
- English greetings such as `hello`, `hi`, `hey`, `good morning`, `good afternoon`, `good evening`, `good night`
- Greeting sequences with punctuation such as `你好！`, `hello, hi`, `早上好～`
- Greeting plus request inputs such as `你好，帮我看一下这个报错`

Update the regex list in `scripts/match_greeting.py` when adding or changing supported greetings. Keep the final reply deterministic by editing the script, not by ad hoc wording in the response.

## Examples

- Input: `你好`
  Output reply: `您好，很高兴为您服务，请问有什么可以协助您？`

- Input: `早上好，帮我总结今天的待办`
  Output reply: `您好，早上好。很高兴为您服务，请问有什么可以协助您？`
  Remaining request: `帮我总结今天的待办`

- Input: `hello!!!`
  Output reply: `您好，很高兴为您服务，请问有什么可以协助您？`

This skill only needs `scripts/match_greeting.py`.
