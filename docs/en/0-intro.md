# 0. What is this? — A guide for people without a Mac

A conceptual introduction for first-time visitors to this repository, including those who don't own a Mac and just want to understand "what is this project?"

> 🕰️ **Need the absolute basics first ("what *is* a local LLM?")?** → read [00-basics.md](00-basics.md) before this.

**🌐 Language**: [한국어](../0-소개.md) · **English (current)**

---

## One-Line Summary

> **A toolkit to run AI models built by Korean companies (EXAONE, A.X, Solar) entirely on your Mac, without the internet.**

---

## 🤔 Why was this built?

### Problem 1. ChatGPT sends your data to US servers every time
- Trade secrets, personal info, medical records → transmitted externally
- Unusable when offline
- Usage limits and subscription costs

### Problem 2. Korean AI models speak Korean better
- Under the Korean government's **"Independent AI Foundation Model (Dokpamo)"** initiative (2025~), LG, SKT, Upstage and others have released their own models
- Korean-dedicated tokenizers → process longer Korean text at the same cost
- Better understanding of native expressions, honorifics, and nuance

### Problem 3. Actually using them is complicated
- Each model has a different download method (Ollama / MLX / Hugging Face)
- Loading a 13GB model on a 24GB laptop crashes other apps
- Memorizing commands is annoying

→ **This repo solves all of that with one-line commands.**

---

## 🇰🇷 What is "Sovereign AI"?

| Mainstream AI (e.g. ChatGPT) | Sovereign AI (this repo) |
|---|---|
| Run by US companies on US servers | Models built by domestic companies |
| Data sent overseas | Processed only inside your computer |
| Internet required | Works offline |
| English is its native language | **Korean is its native language** |
| Subject to foreign policy changes | Maintains national data sovereignty |

**"Sovereign"** = a state where data, technology, and operations don't depend on outside parties.

Why governments worldwide are building national AI:
- 🇰🇷 Korea: "Dokpamo" initiative (LG, SKT, Naver, Upstage, NCSOFT, KT, etc.)
- 🇫🇷 France: Mistral
- 🇯🇵 Japan: Sakana AI, ELYZA
- 🇨🇳 China: Qwen, DeepSeek
- 🇦🇪 UAE: Falcon

---

## 📦 Korean Models Covered Here

### LG AI Research — EXAONE 4.0
- **Lightweight**: ~1.2GB. No burden on a laptop
- **Fast**: Text streams almost in real time (282 chars/sec on M5 Pro)
- **Use cases**: short questions, summarization, quick fact lookup
- **Maker**: LG Group's AI research subsidiary (founded 2020)

### SK Telecom — A.X 4.0 Light
- **Korean specialist**: trained on SKT's own supercomputer (TITAN)
- **Efficient**: saves 33% of Korean tokens compared to GPT-4o
- **Commercial-friendly**: Apache 2.0 license (most permissive)
- **Use cases**: everyday Korean, email, document/business writing

### Upstage — Solar Pro 22B
- **Smartest**: 22B parameters with 70B-class reasoning performance
- **Heavy**: 13GB → pushes a 24GB laptop near its limit
- **MIT license**: built by a Korean startup with global ambitions
- **Use cases**: coding, complex reasoning, professional translation

---

## 💻 What computer do I need?

| Spec | Supported models |
|---|---|
| **Mac M1~M5 Pro/Max, 16GB+** | EXAONE, A.X (lightweight models) |
| **Mac M1~M5 Pro/Max, 24GB+** | Above + Solar (full lineup) ⭐ |
| **Mac M1~M5 Pro/Max, 64GB+** | Above + larger future models (e.g. EXAONE 32B) |
| Intel Mac | ❌ MLX not supported (Ollama only, very slow) |
| Windows / Linux | ⚠️ This script is macOS-only. The models themselves can run on other OSes (separate setup) |

> 💡 **This repo targets Apple Silicon (M-series) only.** To use the same models on Windows/Linux, install [Ollama](https://ollama.com) directly and download the models separately.

---

## ⚡ How is it so fast? — The MLX magic

Apple Silicon (M1~M5) has CPU, GPU, and memory on a single chip — a **unified memory architecture**.
Apple's **MLX** framework leverages this fully:

- Regular laptops: time wasted copying data between GPU and CPU
- M5 Pro + MLX: direct access without copies → **282 chars/sec on a laptop**

→ EXAONE 1.2B runs at speeds comparable to ChatGPT's response rate.

---

## 🚫 What this repo does NOT do

- It does **not build new AI models** (it's a tool that uses what LG/SKT/Upstage already published)
- Not as smart as ChatGPT (1.2B~22B is smaller than GPT-4o, ~1T)
- No image generation / speech recognition / video analysis (text LLMs only)
- No cloud deployment / automated API server (designed for personal laptop use)
- No Windows/Linux support (the models work; this script doesn't)

---

## ❓ Frequently Asked Questions

### Q. So is this a ChatGPT replacement?
A. **Partial replacement.** It's enough for fast Korean Q&A, summarization, email writing, and other daily tasks.
For complex reasoning or up-to-date info, ChatGPT/Claude are still better.

### Q. Does it really work without internet?
A. **Yes.** Once you've downloaded the models, everything is fully offline.
Use it on a plane, in a basement, or inside a secure network.

### Q. Can I input company secrets?
A. They don't leave your machine. But **the model can hallucinate**, so verify outputs before any important decision.

### Q. Is it free?
A. **The models are free** (released by each company), and **this tool is free too** (MIT license).
However, each model has a different commercial-use status:
- A.X: Apache 2.0 (commercial OK)
- Solar: MIT (commercial OK)
- EXAONE: free for research; commercial use requires a separate agreement

### Q. Is this code useful even without a Mac?
A. You can't use it directly, but it's useful as **reference material**:
- Curated list of Korean Sovereign AI models with their characteristics
- Bash script structure (memory management, automated install)
- Ollama / MLX usage examples

---

## 🚀 Next Steps

- If you have a Mac → see [2-install.md](2-install.md) and install
- Want to learn more → [1-overview.md](1-overview.md) (per-model details)
- Curious about the code structure → [README](../../README.en.md)
- Authors / company → [AUTHORS.en.md](../../AUTHORS.en.md)

---

## 🌐 External Resources

- Government policy: ["Independent AI Foundation Model (Dokpamo)" initiative](https://www.korea.kr/) (search)
- LG EXAONE: [huggingface.co/LGAI-EXAONE](https://huggingface.co/LGAI-EXAONE)
- SKT A.X: [huggingface.co/skt](https://huggingface.co/skt)
- Upstage Solar: [huggingface.co/upstage](https://huggingface.co/upstage)
- Apple MLX: [github.com/ml-explore/mlx](https://github.com/ml-explore/mlx)
- Ollama: [ollama.com](https://ollama.com)
