# A2. Fully Manual Install — Do by hand what this repo automates

**🌐 Language**: [한국어](../A2-수동설치.md) · **English (current)**

> This doc walks through every step that `install.sh` / `web-install.sh` automate, **one command at a time**.
> Recommended if you want to "know what's happening before installing", "install on a locked-down work laptop where you can't run scripts", or "adapt this to other models".
>
> If new here → read [A1-glossary.md](A1-glossary.md) first.

---

## 📋 Full flow at a glance

```
0. Environment check
1. Xcode CLT (git, compilers)         ← one time
2. Install Ollama                      ← one time
3. Python + required libraries         ← one time
4. Create model storage folder         ← one time
5. EXAONE — pull via Ollama
6. EXAONE — convert to MLX
7. A.X 4.0 Light — convert to MLX
8. Solar Pro 22B — download GGUF + register with Ollama
9. Add shortcut commands (PATH)
10. (Optional) auto-cleanup cron
```

Each step is independent, so **do only what you need** (e.g. only A.X → skip 5–6).

---

## 0. Environment check (1 minute)

In the terminal:

```bash
# Chip — should be "arm64"
uname -m

# macOS version — 13+ recommended
sw_vers -productVersion

# Memory (GB) — 16+ recommended; 24+ for Solar
sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024) " GB"}'

# Free disk — need 25GB+ for the full install
df -h ~ | awk 'NR==2 {print "free: " $4}'
```

If you're not on `arm64` or have under 16GB, some models (especially Solar) won't fit. Try EXAONE / A.X only.

---

## 1. Xcode Command Line Tools (one time, 5–10 min)

```bash
xcode-select --install
```

A window appears → click **[Install]**. After it finishes:

```bash
git --version          # git version 2.x...
clang --version
```

> ❓ What is it? Apple's bundle of basic developer tools. Includes `git`, compilers, and more.

---

## 2. Install Ollama (one time, 2 min)

### Option A — official site (easiest)
1. Go to <https://ollama.com/download> and click **macOS**
2. Unzip the downloaded `Ollama.zip` → drag `Ollama.app` into **Applications**
3. Launch `Ollama.app` (a llama icon appears in the menu bar = background server is running)

### Option B — Homebrew
```bash
brew install --cask ollama
open -a Ollama       # start the server
```

### Verify
```bash
ollama --version
curl -s http://localhost:11434/api/tags
# Should return a tiny JSON like {"models":[]}
```

> ❓ Port 11434? The port the Ollama server listens on. Conflicts if another program uses it.

---

## 3. Python + libraries (one time, 1 min)

macOS 13+ ships with `python3`. Just check the version:

```bash
python3 --version       # 3.9 or higher = OK
```

### Install the two essentials
```bash
python3 -m pip install --user mlx-lm
python3 -m pip install --user huggingface_hub
```

- `mlx-lm` = library to run/convert models with MLX
- `huggingface_hub` = tool to download from HuggingFace (provides `huggingface-cli`)

### PATH setup (without this, `huggingface-cli not found`)
The installed commands land in `~/Library/Python/3.9/bin/`, but the system doesn't look there yet. Tell it to:

```bash
echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
which huggingface-cli       # /Users/.../bin/huggingface-cli = OK
```

> ❓ What is `~/.zshrc`? The config file zsh reads each time the terminal starts. The right place to set PATH and other env vars.

---

## 4. Create the model storage folder (10 sec)

All MLX models will live in `~/models/`:

```bash
mkdir -p ~/models
ls -la ~/models       # confirm empty folder
```

> ❓ The `-p` in `mkdir -p` means "create intermediate folders if missing". Safe to run twice.

---

## 5. EXAONE 4.0 1.2B — Ollama version (1–3 min, 0.8GB)

```bash
ollama pull hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
```

Once the progress bar finishes:

```bash
# Confirm
ollama list | grep EXAONE

# Chat test
ollama run hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
>>> Hi! Who are you?
[model replies]
>>> /bye          # exit
```

> ❓ What's `Q4_K_M`? A quantization variant. `Q4` = 4-bit; `K_M` = a balanced flavor. Near-original quality, ¼ the size.

---

## 6. EXAONE 4.0 1.2B — MLX 4-bit (2–5 min, 0.7GB)

Same model, **converted to MLX format** for higher speed.

```bash
python3 -m mlx_lm convert \
  --hf-path LGAI-EXAONE/EXAONE-4.0-1.2B \
  --mlx-path ~/models/exaone-4.0-1.2b-4bit-mlx \
  -q
```

- `--hf-path`: HuggingFace repo path
- `--mlx-path`: where to save the converted result on your disk
- `-q`: 4-bit quantization

When done:

```bash
ls ~/models/exaone-4.0-1.2b-4bit-mlx
# config.json  model.safetensors  tokenizer.json  ...
```

Chat test:

```bash
python3 -m mlx_lm chat --model ~/models/exaone-4.0-1.2b-4bit-mlx
>>> Introduce yourself in Korean
[model replies, very fast — ~282 tok/s]
```
Exit: `Ctrl + D`

> ⚠ Out-of-memory during conversion? Close other heavy apps and retry. Or convert on a bigger machine and copy the result folder.

---

## 7. SKT A.X 4.0 Light — MLX 4-bit (15–30 min, 14GB download → 4.5GB)

> ⚠ **The original is 14GB, so the download takes a while.** Let it run in the background.

```bash
python3 -m mlx_lm convert \
  --hf-path skt/A.X-4.0-Light \
  --mlx-path ~/models/ax-4.0-light-4bit-mlx \
  -q
```

Internally:
1. Downloads the BF16 original from HuggingFace into `~/.cache/huggingface/` (14GB)
2. Converts to 4-bit and saves to `~/models/ax-4.0-light-4bit-mlx/` (4.5GB)

Verify:

```bash
ls -la ~/models/ax-4.0-light-4bit-mlx
du -sh ~/models/ax-4.0-light-4bit-mlx     # 4.5G
```

Chat:

```bash
python3 -m mlx_lm chat --model ~/models/ax-4.0-light-4bit-mlx
```

### Reclaim disk (optional)
After conversion, the 14GB original in `~/.cache/huggingface/` can be **deleted** without affecting the converted model:

```bash
du -sh ~/.cache/huggingface     # 14GB+
rm -rf ~/.cache/huggingface     # reclaim (model still works)
```

---

## 8. Upstage Solar Pro 22B — Ollama (20–40 min, 13GB)

For Solar, download the GGUF and register it with Ollama.

### 8-1. Download the GGUF
```bash
mkdir -p ~/models/solar-pro
huggingface-cli download MaziyarPanahi/solar-pro-preview-instruct-GGUF \
  --include "solar-pro-preview-instruct.Q4_K_M.gguf" \
  --local-dir ~/models/solar-pro
```

Verify:
```bash
ls -lh ~/models/solar-pro/
# solar-pro-preview-instruct.Q4_K_M.gguf  (13GB)
```

### 8-2. Write a Modelfile
"Register this GGUF under the name `solar-pro`":

```bash
cat > /tmp/solar.modelfile <<EOF
FROM $HOME/models/solar-pro/solar-pro-preview-instruct.Q4_K_M.gguf
EOF

cat /tmp/solar.modelfile      # confirm contents
```

### 8-3. Register with Ollama
```bash
ollama create solar-pro -f /tmp/solar.modelfile
ollama list | grep solar
```

### 8-4. Chat
```bash
ollama run solar-pro
>>> Write a Python Fibonacci function
[model replies]
>>> /bye
```

> ⚠ On a 24GB Mac, Solar is tight. Close Chrome / Slack / VS Code first.

---

## 9. Shortcut commands (PATH) — optional but highly recommended

Typing `python3 -m mlx_lm chat --model ~/models/ax...` every time is annoying. This repo's `bin/` folder has shortcut scripts. Add it to PATH and you can run `ax`, `exaone-mlx`, etc. anywhere.

```bash
# Locate this repo
cd ~/DEV/llmDev/korea-ai          # adjust to your location
pwd

# Add one PATH line to .zshrc
echo "export PATH=\"$PWD/bin:\$PATH\"  # korea-ai launchers" >> ~/.zshrc
source ~/.zshrc

# Verify
which ax           # /.../korea-ai/bin/ax
ax "Hello"         # one-shot question
```

To roll your own, look at [bin/ax](../../bin/ax) and friends — they're essentially:

```bash
#!/usr/bin/env bash
python3 -m mlx_lm chat --model ~/models/ax-4.0-light-4bit-mlx "$@"
```

One-line wrapper scripts.

---

## 10. (Optional) auto-cleanup cron

Free memory every Sunday at 04:00:

```bash
crontab -e
```
The editor opens — add at the bottom:
```
0 4 * * 0 /Users/mo/DEV/llmDev/korea-ai/maintain.sh --auto >> ~/.korea-ai-maint.log 2>&1
```
Save and exit. Confirm:
```bash
crontab -l
```

> ❓ The `0 4 * * 0` format? `min hour day month weekday`. 0 = Sunday.

---

## 🧪 Full check

Once everything's installed:

```bash
# Ollama models
ollama list
# → both EXAONE and solar-pro should be listed

# MLX model folders
ls ~/models/
# → exaone-4.0-1.2b-4bit-mlx, ax-4.0-light-4bit-mlx

# Disk usage
du -sh ~/models/*/
du -sh ~/.ollama/models
```

Quick chat sanity-check:
```bash
echo "Hi" | ollama run hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
echo "Hi" | ollama run solar-pro
python3 -m mlx_lm generate --model ~/models/ax-4.0-light-4bit-mlx --prompt "Hi"
```

---

## 🆘 Common pitfalls

### `huggingface-cli: command not found`
Step 3 PATH not set. Run `source ~/.zshrc` or open a fresh terminal.

### `python3 -m mlx_lm: No module named mlx_lm`
Step 3 pip install failed or skipped. Retry:
```bash
python3 -m pip install --user mlx-lm
```

### `ollama: command not found`
Step 2 not done, or brew's path isn't on PATH.
```bash
ls /Applications/Ollama.app
which ollama
```

### `Address already in use` (port 11434)
Ollama is already running. Either fine, or for a conflict:
```bash
pkill -f ollama
open -a Ollama
```

### Out-of-memory during MLX conversion
Close other apps and retry. Converting 14GB originals is memory-hungry.

### A.X download stalls
HF cache supports resume. Re-run the same command and it picks up from where it stopped.

### Disk full
- Delete `~/.cache/huggingface` (safe after conversion)
- Use `ollama rm <model>` to remove unused Ollama models

---

## 🔁 Full uninstall (manual)

```bash
# 1. Ollama models
ollama rm hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
ollama rm solar-pro

# 2. MLX models
rm -rf ~/models/exaone-4.0-1.2b-4bit-mlx
rm -rf ~/models/ax-4.0-light-4bit-mlx
rm -rf ~/models/solar-pro

# 3. HF cache
rm -rf ~/.cache/huggingface

# 4. PATH entries
sed -i '' '/korea-ai/d' ~/.zshrc
sed -i '' '/Library\/Python\/3.9\/bin/d' ~/.zshrc

# 5. (optional) Ollama itself
brew uninstall --cask ollama   # or drag Ollama.app to Trash
rm -rf ~/.ollama

# 6. (optional) Python packages
python3 -m pip uninstall mlx-lm huggingface_hub

# 7. cron
crontab -l | grep -v korea-ai | crontab -
```

---

## ✨ Done?

You can now handle Korean Sovereign AI models without this repo. Things to try:

- Other Korean models the same way: `LGAI-EXAONE/EXAONE-4.0-7.8B`, `naver-hyperclovax/...`, etc.
- Foreign models: `meta-llama/Llama-3-8B`, `Qwen/Qwen3-7B`, etc.
- Build your own shortcut commands → see [bin/ax](../../bin/ax)
- Build your own install.sh → see [install.sh](../../install.sh)

**Next:**
- [3-usage.md](3-usage.md) — menu / shortcut command usage
- [4-maintenance.md](4-maintenance.md) — routine maintenance
- [A1-glossary.md](A1-glossary.md) — refresh the vocab
