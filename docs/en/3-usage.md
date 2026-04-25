# 🇰🇷 Korean Sovereign AI — User Guide

**🌐 Language**: [한국어](../3-사용법.md) · **English (current)**

> How to use Korean AI models (EXAONE, A.X, Solar) installed on your computer **without the internet**, directly on your Mac.
> Written so non-developers can follow along.

---

## 📌 What is Korean Sovereign AI?

**Sovereign AI** = AI models built by domestic Korean companies and research institutes:
- Data does not leave the country
- Best understanding of the Korean language
- Core candidates of the government's "Independent AI Foundation Model (Dokpamo)" initiative

This laptop has the three Korean flagships installed:

| Model | Maker | One-line description |
|---|---|---|
| **EXAONE 4.0 1.2B** | LG AI Research | Small and fast. Ideal for short questions / summaries |
| **A.X 4.0 Light** | SK Telecom | Smoothest Korean. Daily conversation, work emails |
| **Solar Pro 22B** | Upstage | Smartest. Complex reasoning, coding, translation |

> 💡 **All work without internet.** Your questions are not sent anywhere.

---

## 🚀 Get started in 1 minute

Open the Terminal app and type:

```bash
cd ~/DEV/llmDev/korea-ai
./launcher.sh
```

A menu like this appears:

```
===============================
 🇰🇷 Korean Sovereign AI Launcher
===============================
 (memory clean)
 /exaone      EXAONE 1.2B (Ollama)        ~0.8GB
 /exaone-mlx  EXAONE 1.2B (MLX 4bit)      ~0.7GB ★ Fastest
 /ax          SKT A.X 4.0 Light (MLX)     ~4.5GB ★ Strong Korean
 /solar       Solar Pro 22B (Ollama)      ~13GB
 /unload      Force memory cleanup
 /ps          Show currently loaded models
 /help        Help
 /quit        Exit
-------------------------------
>
```

Type a command next to `>` and press Enter.

**Examples:**
- `/ax` → start A.X 4.0 Korean chat
- `1` or `/exaone` → start EXAONE
- `/quit` → exit the launcher

---

## 💬 How to chat

Once a model starts, just ask in Korean (or English).

```
> /ax
▶ SKT A.X 4.0 Light (MLX 4bit) — ~4.5GB, strongest Korean
  Exit: Ctrl+D

>>> Draft an email announcing the company workshop schedule
[model replies]

>>> Make it shorter
[model replies]
```

### How to end the chat and return to the menu

| Model type | How to exit |
|---|---|
| `/exaone`, `/solar` (Ollama) | Type `/bye` and press Enter |
| `/exaone-mlx`, `/ax` (MLX) | Press `Ctrl + D` |

When you exit, you go back to the menu automatically. If you pick another model, **the previous one is unloaded from memory automatically** (no need to worry).

---

## 🎯 Which model should I pick?

### By scenario

**📩 Korean email / docs / everyday questions → `/ax`**
- Most natural Korean phrasing
- Handles Korean tones like "polite formal email" or "casual KakaoTalk style" well
- ~4.5GB memory

**⚡ Quick answers to short questions → `/exaone-mlx`**
- 282 tokens/sec, text streams almost in real time
- Short summaries, simple translations, quick fact lookups
- ~0.7GB memory (lightest)

**🧠 Hard tasks (coding, long reasoning, expert translation) → `/solar`**
- 22B, the smartest of the three
- But uses 13GB of memory → close heavy apps (Chrome, Slack, VS Code) before using
- Slower, but higher quality

**🤔 Not sure → start with `/ax`**
The safest pick for Korean-speaking users.

---

## 🧹 Memory management

With 24GB RAM, large models can slow down other apps.

### Free memory after you're done

In the launcher:
```
> /unload
✓ Cleanup done
```

Or from the terminal directly:
```bash
./launcher.sh /unload
```

### Check what's currently in memory

```
> /ps
NAME                     SIZE     UNTIL
solar-pro:latest         15 GB    4 minutes from now
```

> 💡 When you switch models (e.g. `/exaone` → `/solar`), the previous model is unloaded **automatically** — no action needed. `/unload` is the "drop everything right now" override.

---

## 🆘 Frequently Asked Questions

### Q. Will it work with no internet?
A. **Yes, it runs fully offline.** The models live on your computer.

### Q. Are my questions/conversations leaked anywhere?
A. **No.** No external server calls — everything runs inside your Mac.

### Q. What if the model gives a wrong answer?
A. AI sometimes states wrong info confidently (hallucination). **Always verify before using it for important decisions.**

### Q. My Mac gets hot and slow
A. Likely due to a big model like `/solar` (22GB-class). Run `/unload`, or stick with lighter models like `/ax` or `/exaone-mlx` for daily use.

### Q. Replies suddenly come in English
A. Add "Reply in Korean" at the end of your prompt, or switch to `/ax` (specialized for Korean).

### Q. How do I quit?
A. Type `/quit` in the menu, or press `Ctrl + C`. (Memory is cleaned up automatically.)

### Q. How do I start it again next time?
A. In the terminal: `cd ~/DEV/llmDev/korea-ai && ./launcher.sh` — done.

---

## 🛟 If something breaks

### "command not found" error
Check the path:
```bash
ls ~/DEV/llmDev/korea-ai/launcher.sh
```
If the file is listed, you're fine. If not, contact the developer.

### The menu is unresponsive
Press `Ctrl + C` to exit and start over:
```bash
./launcher.sh /unload   # clean memory first
./launcher.sh           # restart
```

### Replies are too slow
- If you're on a big model (`/solar`), switch to a smaller one (`/ax`, `/exaone-mlx`)
- Close other heavy apps (lots of Chrome tabs, VS Code, etc.)

### The model keeps producing nonsense
- Be more specific: "Write an email" → "Write a 5-sentence polite email asking the client to push our meeting back by 30 minutes"
- For Korean quality, prefer `/ax`; for reasoning quality, prefer `/solar`

---

## 📚 Want to know more?

- Help (model background / licenses / Korean Sovereign AI policy context):
  ```bash
  ./launcher.sh /help
  ```
- Developer docs: [README](../../README.en.md)
- Shortcut commands (`exaone`, `ax`, etc.): [bin/ section in the README](../../README.en.md)

---

## ✅ One-page cheat sheet (print and keep nearby)

```
Start:           cd ~/DEV/llmDev/korea-ai && ./launcher.sh
Korean chat:     /ax       (type in the menu)
Quick question:  /exaone-mlx
Hard task:       /solar
Quit:            Ctrl+D (MLX) / /bye (Ollama) → /quit
Free memory:     /unload
Help:            /help
```
