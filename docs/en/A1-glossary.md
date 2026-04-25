# A1. Glossary — "What is that?" reference

**🌐 Language**: [한국어](../A1-개념사전.md) · **English (current)**

> This doc starts at an **even lower level** than [00-basics.md](00-basics.md).
> It answers questions like "what's a terminal?", "how do I make a folder?", "what's Hugging Face?" one by one.
> Search for an entry, or read top-to-bottom — both work.

---

## 🗂️ Contents

| # | Category | Items |
|---|---|---|
| 1 | **Computer basics** | Terminal · folder · path · file extensions · commands · `~` |
| 2 | **Install/download tools** | brew · pip · git · curl · xcode-select |
| 3 | **AI tools** | Hugging Face · Ollama · MLX · model file formats (GGUF / safetensors) |
| 4 | **Concepts** | Model · token · parameter · quantization · inference vs. training |
| 5 | **Where files live** | `~/models/` · `~/.ollama/` · `~/.zshrc` |

---

# 1. Computer Basics

## Terminal

**A black-screen app where you control the computer by typing.**

- macOS built-in: `Applications → Utilities → Terminal.app`
- Quick open: `Cmd + Space` → type "Terminal" → Enter
- The text you type = "commands"
- No mouse, just keyboard

**Why use it?** Things like running AI models, git, and installs are faster and easier to automate than with a GUI.

```
First-screen example:
mo@MacBook ~ %
└─ user  host  current-dir  prompt
```

The trailing `%` (or `$`) means "type your command here". After typing, press Enter.

---

## Folder (Directory)

**A box that holds files.** Same as the yellow folders in Windows.

- Also called "directory" (same thing)
- Folders can contain folders → tree structure

### Folder commands in the terminal

| What you want | Command | Example |
|---|---|---|
| What folder am I in? | `pwd` | `/Users/mo` |
| What's in this folder? | `ls` | (file list) |
| Move to another folder | `cd <name>` | `cd Documents` |
| Up one level | `cd ..` | |
| Home folder | `cd ~` or just `cd` | |
| **Make a new folder** | `mkdir <name>` | `mkdir models` |
| **Make several at once** | `mkdir -p a/b/c` | (b inside a, c inside b) |
| Delete (empty) folder | `rmdir <name>` | |
| Delete folder + contents ⚠ | `rm -rf <name>` | (dangerous! be careful) |

### Make a folder in Finder
1. Open Finder → go where you want
2. `Cmd + Shift + N` (new folder shortcut)
3. Type a name → Enter

---

## Path

**The address that says where a file or folder lives.**

```
/Users/mo/DEV/llmDev/korea-ai/README.md
└── root  user   your folders ...        file
```

- Starts with `/` = absolute path (always points to the same place)
- `./` or just a name = relative path (relative to where you are now)

### `~` (tilde)
**Shortcut for "my home folder".**
- `~` = `/Users/mo` (your user home)
- `~/models` = `/Users/mo/models`
- `~/.zshrc` = `/Users/mo/.zshrc`

### Hidden folders/files
Names starting with `.` are hidden (invisible in Finder).
- e.g. `~/.ollama/`, `~/.zshrc`
- Show in Finder: `Cmd + Shift + .` (period)
- Show in terminal: `ls -a`

---

## File extensions

The dot + letters at the end indicate file type.

| Extension | Meaning | In this repo |
|---|---|---|
| `.md` | Markdown document | README.md, docs/* |
| `.sh` | shell script (executable) | install.sh, launcher.sh |
| `.py` | Python code | bin/mlx-chat |
| `.gguf` | model file for Ollama | solar-pro-...gguf |
| `.safetensors` | model file for MLX/HF | model.safetensors |
| `.json` | configuration file | config.json |

---

## Commands / arguments / options

```
ollama pull EXAONE-4.0-1.2B
└─ command └subcmd └ argument
```

```
./install.sh --yes --minimal
└─ executable    └ option └ option
```

- Starts with `--xxx` or `-x` = option (flag)
- Plain word = argument

### Useful keys
- `Tab` = autocomplete (after typing partway, fills in the rest)
- `↑` / `↓` = recall previous commands
- `Ctrl + C` = stop running command
- `Ctrl + D` = end of input (used to exit MLX chat)
- `Cmd + K` = clear screen

---

# 2. Install / download tools

## Homebrew (`brew`)
**The "vending machine" for macOS programs.** One-line installs.

```bash
brew install git              # install git
brew install --cask ollama    # install the Ollama app
```
Official: <https://brew.sh>

> 💡 This repo's `web-install.sh` works without brew, but brew is convenient.

---

## pip (Python package manager)
**Installs Python libraries (collections of code).**

```bash
python3 -m pip install --user mlx-lm
python3 -m pip install --user huggingface_hub
```
- `--user` = install to your account only (no admin rights needed)
- This repo uses `mlx-lm` (MLX inference) and `huggingface_hub` (HF downloads)

---

## git
**Source code version control.** Required to fetch code from GitHub.

```bash
git --version                  # check install
git clone <URL>                # fetch code
git pull                       # update
git status                     # current state
```
If missing, install via `xcode-select --install`.

---

## curl
**Downloads files/data from the internet.** Built into virtually every OS.

```bash
curl -fsSL <URL> | bash       # fetch and run immediately (this repo's one-liner)
```
- `-f` = fail silently on HTTP errors
- `-s` = hide progress
- `-S` = still show errors
- `-L` = follow redirects

---

## xcode-select
Apple's command for installing the **Command Line Tools**.

```bash
xcode-select --install         # a window appears → click [Install], wait 5–10 min
```
This brings in `git`, `make`, `clang`, etc. **Practically required before using this repo.**

---

# 3. AI tools — the big picture

```
┌─────────────────────────────────────────────────────────┐
│   Where to get models = Hugging Face (the warehouse)   │
│            ↓ download                                    │
│   Tools that run them:                                   │
│      ① Ollama   (easy, all OSes, GGUF format)            │
│      ② MLX-LM   (Apple-only, fastest, safetensors)       │
└─────────────────────────────────────────────────────────┘
```

---

## Hugging Face 🤗

**The "GitHub" for AI models and datasets.** Where the world publishes and downloads models.

- Web: <https://huggingface.co>
- LG, SKT, and Upstage all publish their Korean models here
- You can download without signing up (some require accepting terms)

### Key terms
- **Repository (repo)**: a folder containing one model (e.g. `LGAI-EXAONE/EXAONE-4.0-1.2B`)
- **Model card**: that model's README (specs, license, usage)
- **`huggingface-cli`**: a terminal tool to download

```bash
# Download the entire A.X 4.0 Light model
huggingface-cli download skt/A.X-4.0-Light --local-dir ~/models/ax-original
```

> ⚠️ Models are usually **a few GB to tens of GB**. Mind your disk and bandwidth.

---

## Ollama 🦙

**The easiest way to run a local AI.**

- Official: <https://ollama.com>
- Install the macOS app → it runs a background server (`localhost:11434`) and you talk to it via commands

```bash
ollama --version              # confirm install
ollama pull llama3            # download a model
ollama run llama3             # start a chat
ollama list                   # downloaded models
ollama ps                     # what's currently in memory
ollama stop llama3            # unload from memory
ollama rm llama3              # delete from disk
```

### Modelfile
Ollama's "model recipe". Used to register a GGUF file.

```
FROM /Users/mo/models/solar-pro/solar-pro-...gguf
```
Save that one line as a file, then `ollama create solar-pro -f thatfile` → registered.

### Where models are stored
Inside `~/.ollama/models/`. Back this up to skip future re-pulls.

---

## MLX / mlx-lm

**Apple's AI framework, exclusive to Apple Silicon.**

- Official: <https://github.com/ml-explore/mlx>
- Optimized for the M1~M5 unified memory architecture → much faster
- Used as a Python library (`pip install mlx-lm`)

```bash
# Convert a HuggingFace model to MLX 4-bit (one-time)
python3 -m mlx_lm convert \
  --hf-path skt/A.X-4.0-Light \
  --mlx-path ~/models/ax-4.0-light-4bit-mlx -q

# Chat with the converted model
python3 -m mlx_lm chat --model ~/models/ax-4.0-light-4bit-mlx
```

> 💡 Conversion compresses "original (BF16, big) → 4-bit (small)". Done once, reused forever.

---

## Model file formats compared

| Format | Used by | Notes |
|---|---|---|
| **`.safetensors`** | HuggingFace, MLX | Safe tensor storage; a model folder has multiple files (config.json + model.safetensors + tokenizer.json …) |
| **`.gguf`** | Ollama, llama.cpp | Single file with quantization info embedded (Q4_K_M, etc.) |
| `.bin` (older) | Old PyTorch format | Rarely used now; replaced by safetensors due to security |

The same model often exists in both formats. Pick the one your tool wants.

---

# 4. Concepts (quick reference)

(Details in [00-basics.md](00-basics.md). Here's the cheat sheet.)

| Term | One-liner |
|---|---|
| **Model** | The "brain" of an AI = a giant file of numbers |
| **LLM** | An AI model that takes text in and produces text |
| **Token** | The smallest unit a model processes (1 Korean char ≈ 1–3 tokens) |
| **Parameter** | Number of "neuron-connection strengths" in the model (B = billion) |
| **Quantization** | Compressing a model to 4-bit etc. → ¼ the memory |
| **Context length** | Max tokens it can hold in mind at once |
| **Inference** | Producing answers with a model (= what we do) |
| **Training** | Building a new model (= what LG/SKT do) |
| **Prompt** | The input you give a model (question/instruction) |
| **Hallucination** | When a model confidently states something false |

---

# 5. Where files actually live

```
~ (= /Users/<your-username>)
├── DEV/llmDev/korea-ai/        ← this repo (the scripts)
├── models/                     ← MLX-converted models (you create this)
│   ├── exaone-4.0-1.2b-4bit-mlx/
│   └── ax-4.0-light-4bit-mlx/
├── .ollama/                    ← Ollama auto-creates
│   └── models/                  └── downloaded GGUFs / blobs
├── .cache/huggingface/         ← HF auto-creates (BF16 originals cache)
└── .zshrc                      ← terminal settings (PATH lives here)
```

> 💡 When disk gets tight:
> - `du -sh ~/models/*` — sizes of MLX models
> - `du -sh ~/.cache/huggingface` — HF cache size (safe to delete after conversion)
> - `du -sh ~/.ollama/models` — Ollama model size

---

## 🚀 Next

Now that the vocabulary makes sense:
- Want to install step-by-step by hand → **[A2-manual-install.md](A2-manual-install.md)** ⭐ Everything this repo automates, done manually
- Just install quickly → [2-install.md](2-install.md)
- How to use → [3-usage.md](3-usage.md)
