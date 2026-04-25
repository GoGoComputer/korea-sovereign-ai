# 00. Absolute Basics — What is a Local LLM?

**🌐 Language**: [한국어](../00-기초.md) · **English (current)**

> "I've heard of AI, but local LLM? MLX? Ollama? Quantization? Tokens? …" Don't worry if none of that means anything yet.
> This doc explains every term **from scratch**, even if you're not technical.
> By the end, you'll naturally understand why this repo exists and what it does.

---

## 0. The mental model in one picture

```
   ┌────────────────────────────────────────────────────────┐
   │                                                        │
   │   Your question → [ AI model ] → Answer               │
   │                                                        │
   └────────────────────────────────────────────────────────┘

   ChatGPT / Claude / Gemini:
       Question → [Internet] → Huge AI on US server → [Internet] → Answer
       (an external company sees your question)

   Local LLM (this repo):
       Question → [AI inside your Mac] → Answer
       (no internet, nothing leaves your machine)
```

This repo helps you build the second picture. **That's it.**

Now let's unpack what each word actually means.

---

## 1. What are AI / Model / LLM?

### AI (Artificial Intelligence)
A general term for computer programs that "judge / understand / generate" like humans. Too broad on its own, so people usually **break it into types**.

### Model
The "brain" of an AI — a **huge file of numbers**. What we casually call "an AI" is really this model file.
- Sizes range from hundreds of MB to hundreds of GB
- Companies train them on supercomputers for months
- **Once made, we just download and use them**

### LLM (Large Language Model)
A model that **understands text and replies in text**. ChatGPT is the canonical LLM.
- Input: text (sentences, questions, code)
- Output: text (answers, summaries, translations)
- Doesn't draw images or recognize speech (those are different model types)

> 💡 **Everything in this repo is an LLM** — EXAONE, A.X, Solar all take text in and produce text out.

---

## 2. So what's a "Local LLM"?

### Local = "on my own computer"
"Local LLM" = **an LLM that runs inside your computer**.

### Cloud LLM vs Local LLM

| | Cloud LLM (e.g. ChatGPT) | Local LLM (this repo) |
|---|---|---|
| **Where it runs** | Massive datacenters in the US / overseas | Your Mac |
| **Internet** | Required | Not needed (after first download) |
| **Data** | Sent to external servers | Never leaves your computer |
| **Cost** | Usually monthly subscription ($20+) | Models are free (just storage) |
| **Speed** | Fast (powerful servers) | Depends on your machine |
| **Quality** | Very high (hundreds of billions of params) | Lower (single-digit billions) |
| **Censorship/blocks** | At the company's discretion | Your call |
| **When internet goes down** | Unusable | Works fine |

> 💡 **Both have trade-offs**, so most people use them together. Sensitive material, offline work, daily tasks → local. Hard reasoning → ChatGPT.

---

## 3. Why use a Local LLM? — 5 reasons

### ① Privacy
- Putting trade secrets, personal info, or medical records into ChatGPT **transmits them to external servers**
- A local LLM uses no internet, so data doesn't leak

### ② Offline operation
- Works on a plane, in a basement, in a secure network, anywhere with no internet
- Models are downloaded once, forever

### ③ Cost
- ChatGPT Plus = $20/month
- Local LLM = **models are free** (only marginal electricity)

### ④ Speed
- For short questions, local can be faster (no network round-trip)
- Larger models can be slower depending on hardware

### ⑤ Native language / domain specialization
- Models built by Korean companies **understand Korean better** (Korean tokenizers, trained on Korean data)
- Many models are also tuned for medical, legal, finance, etc.

---

## 4. Common terms, defined

### Token
The **smallest unit** of text the model processes. An English word is usually 1 token; Korean breaks into syllable-like fragments, often 1–3 tokens.
- "안녕하세요" → ~3–4 tokens
- "Hello" → 1 token
- Models have a "maximum X tokens at once" limit (= context length)

### Parameter
The number of "neuron-connection strength values" inside the model. **Bigger = smarter, but heavier.**
- EXAONE 1.2B = 1.2 billion
- Solar 22B = 22 billion
- GPT-4 (estimated) = 1+ trillion
- B = Billion (10⁹)

### Quantization
A technique to **compress** the model so it uses less memory and disk. Small quality loss, ½ – ¼ the size.
- BF16 = original (16 bits per number)
- Q4 / 4-bit = compressed to 4 bits (4× smaller, almost the same quality)
- This repo mostly uses **4-bit quantized models** (memory-friendly)

### Context length
How much text the model can hold in mind at once, measured in tokens.
- A.X 4.0: 32,768 tokens (≈ a whole book of Korean)
- Too short → can't summarize long documents

### Inference
The process of **producing answers** — the opposite of "training".
- Training: company uses a supercomputer to build the model (millions of dollars)
- Inference: we use the finished model to get answers (works on a personal computer)

> 💡 **This repo only does inference.** The models are pre-trained by LG / SKT / Upstage; we just use them.

---

## 5. Tool names explained — Ollama / MLX / Hugging Face

To run a local LLM you need **a model file** + **a program to run it**. The usual suspects:

### Ollama
- **The easiest way to run a local LLM**
- macOS / Windows / Linux supported
- One-line commands to download and run models
- Analogy: "App Store + runner for AI models"
- Official: [ollama.com](https://ollama.com)

### MLX (Apple)
- **Apple's framework for running AI fast on Apple Silicon (M1~M5)**
- Built by Apple to exploit unified memory
- The same model runs much faster on MLX (282 tok/s on M5 Pro)
- macOS only (Apple Silicon)
- Official: [github.com/ml-explore/mlx](https://github.com/ml-explore/mlx)

### Hugging Face
- **The "GitHub" of AI models** — a hub where models live
- LG, SKT, Upstage — they all publish here
- Download with the `huggingface-cli` command
- Official: [huggingface.co](https://huggingface.co)

### GGUF / safetensors
- Names of model **file formats**
- GGUF = format Ollama uses
- safetensors = format MLX / Hugging Face use
- The same model is often available in both (this repo picks the right one per model)

---

## 6. Unified Memory / 4-bit / 282 tok/s — why it's so fast

### Apple Silicon's Unified Memory
Regular PCs: CPU memory and GPU memory are separate → constant data copying (slow)
M1~M5: CPU, GPU, and memory on one chip → **direct access without copies** (fast)

### 4-bit quantization + MLX = explosive speed
- Compress the model to 4-bit → ¼ the memory
- MLX accesses unified memory instantly
- Result: **ChatGPT-like speed on a laptop**

### Measured (M5 Pro 24GB)
- EXAONE 1.2B (MLX 4-bit): **282 tok/s** (≈ 200 Korean characters/sec)
- A.X 4.0 Light (MLX 4-bit): ~65 tok/s
- Solar 22B (Ollama Q4): ~10–15 tok/s

> 💡 People typically read at 5–10 tok/s, so it's **faster than your eyes can keep up**.

---

## 7. "OK, how do I actually start?"

### If you have a Mac
1. [docs/en/0-intro.md](0-intro.md) — why this repo was built (lighter intro)
2. [docs/en/2-install.md](2-install.md) — one-line install
3. [docs/en/3-usage.md](3-usage.md) — how to use the menu

Or just one line in your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash
```

### If you don't have a Mac
- This doc + [docs/en/0-intro.md](0-intro.md) + [docs/en/1-overview.md](1-overview.md) are enough to **understand the Korean Sovereign AI landscape**
- To try something similar on Windows/Linux: install [Ollama](https://ollama.com), then `ollama run llama3` etc. (this repo's scripts are macOS-only)

---

## 8. Beginner FAQ

### Q. Is a local LLM really as smart as ChatGPT?
A. **No.** The parameter gap is huge (GPT-4 ~1T vs. local 1.2B–22B). But it's plenty for everyday Korean Q&A, summaries, and email drafts.

### Q. No internet at all?
A. **Only when first downloading the model.** After that, fully offline.

### Q. How does a 22B model fit on a 24GB Mac?
A. Thanks to **quantization**. The original BF16 is 44GB; compressed to 4-bit it's 13GB.

### Q. Do I need both Ollama and MLX?
A. **Yes** — different models work best with different tools. The `install.sh` here sets up both for you.

### Q. Where are model files stored?
A. `~/models/` (MLX) and `~/.ollama/models/` (Ollama). Around 25GB total.

### Q. What if the model gives wrong answers?
A. All LLMs **hallucinate** — they can confidently state false things. Always verify important facts.

### Q. "1.2B is small and dumb" — why use it?
A. **Speed and efficiency.** For quick answers, summaries, and simple translation, 1.2B is plenty, and uses under 1GB of memory. For hard tasks, switch to the 22B model.

### Q. Why is "Korean Sovereign AI" important?
A. So Korean data, technology, and operations don't depend on outside parties. → Details: [docs/en/0-intro.md](0-intro.md)

---

## 9. Going deeper

| Topic | Recommended sources |
|---|---|
| Korean Sovereign AI landscape | [docs/en/0-intro.md](0-intro.md), [docs/en/1-overview.md](1-overview.md) |
| Government "Independent AI Foundation Model (Dokpamo)" initiative | Search "Dokpamo" / Korean Ministry of Science and ICT |
| How LLMs work | "Transformer architecture", "Attention is All You Need" paper |
| Apple MLX | [github.com/ml-explore/mlx](https://github.com/ml-explore/mlx) |
| Ollama | [ollama.com](https://ollama.com) |
| Hugging Face | [huggingface.co](https://huggingface.co) |

---

## 🚀 Next

- Curious already → [0-intro.md](0-intro.md) (this repo's own intro)
- Just want to install → [2-install.md](2-install.md)
- Want to know the model lineup → [1-overview.md](1-overview.md)
