# 2. First-Time Install

**🌐 Language**: [한국어](../2-설치.md) · **English (current)**

For a brand-new Mac, or an environment that has never had this installed.

## Prerequisites (one time)

### 1. Install Ollama
Download the macOS build from [ollama.com/download](https://ollama.com/download) → run Ollama.app.

Verify:
```bash
ollama --version
curl -s http://localhost:11434/api/tags    # any (even empty) response = OK
```

### 2. Python 3.9+ (preinstalled on macOS)
```bash
python3 --version              # 3.9+
```

### 3. (Auto-installed) dependencies
`install.sh` installs them for you, but to install manually in advance:
```bash
python3 -m pip install --user mlx-lm huggingface_hub
```

`huggingface-cli` lands in `~/Library/Python/3.9/bin`, so confirm your PATH:
```bash
echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
which huggingface-cli
```

---

## Automatic install (recommended)

```bash
cd ~/DEV/llmDev/korea-ai

./install.sh                # Interactive (confirm each model)
./install.sh --yes          # Fully automatic
./install.sh --minimal      # EXAONE + A.X only (~5GB, no Solar)
./install.sh --check        # Status only (no install)
```

Install steps (idempotent — already-installed pieces are skipped):

| # | Step | Size | Time |
|---|---|---|---|
| 0 | Environment check (Apple Silicon, RAM) | — | 1s |
| 1 | PATH registration (`~/.zshrc`) | — | 1s |
| 2 | Python deps (mlx-lm, huggingface_hub) | — | 30s |
| 3 | Ollama health check | — | 1s |
| 4 | EXAONE Ollama pull | 0.8GB | 1–3 min |
| 5 | EXAONE MLX conversion | 0.7GB | 2–5 min |
| 6 | **A.X 4.0 BF16 download + 4-bit conversion** | 14GB→4.5GB | 15–30 min |
| 7 | Solar Pro GGUF download + register | 13GB | 20–40 min |
| 8 | (optional) Weekly auto-maintenance cron | — | 1s |

> ⏱ Total download ~**28GB**, time 30–70 min (depends on network).
> In `--minimal` mode: ~5GB / 5–10 min.

---

## Verify after install

```bash
source ~/.zshrc          # not needed in a fresh terminal
ai-status                # confirm every model shows ✓
```

Expected output:
```
🇰🇷 Korean Sovereign AI status (Mac M5 Pro 24GB)
────────────────────────────────────────────
 ✓ ollama serve

[Models]
 ✓ exaone        LG EXAONE 1.2B (Ollama)
 ✓ exaone-mlx    LG EXAONE 1.2B (MLX)   (697M)
 ✓ ax            SKT A.X 4.0 Light (MLX)   (3.8G)
 ✓ solar         Upstage Solar Pro 22B
```

First chat test:
```bash
./launcher.sh /ax
>>> Hi! Do you speak Korean well?
```

---

## Manual install (when auto fails)

### EXAONE Ollama
```bash
ollama pull hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
```

### EXAONE MLX
```bash
python3 -m mlx_lm convert \
  --hf-path LGAI-EXAONE/EXAONE-4.0-1.2B \
  --mlx-path ~/models/exaone-4.0-1.2b-4bit-mlx -q
```

### A.X 4.0 Light MLX
```bash
python3 -m mlx_lm convert \
  --hf-path skt/A.X-4.0-Light \
  --mlx-path ~/models/ax-4.0-light-4bit-mlx -q
```

### Solar Pro GGUF + Ollama register
```bash
mkdir -p ~/models/solar-pro
huggingface-cli download MaziyarPanahi/solar-pro-preview-instruct-GGUF \
  --include solar-pro-preview-instruct.Q4_K_M.gguf \
  --local-dir ~/models/solar-pro

cat > /tmp/solar.modelfile <<EOF
FROM /Users/$USER/models/solar-pro/solar-pro-preview-instruct.Q4_K_M.gguf
EOF
ollama create solar-pro -f /tmp/solar.modelfile
```

---

## Troubleshooting

### `huggingface-cli: command not found`
```bash
python3 -m pip install --user huggingface_hub
echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### `ollama: Error: model "..." not found`
```bash
./install.sh --check         # status check
./install.sh                 # install only what's missing
```

### Out of Memory during MLX conversion
Close other apps and retry. Or convert on a machine with more RAM and copy the directory.

### A.X download is too slow
The original is 14GB, so it's unavoidable. Leave it running in the background and use EXAONE/Solar in the meantime.
If the download hangs, re-running `install.sh` will resume from the HF cache.

### `Address already in use` (port 11434)
Ollama is already running. `pkill ollama` and retry.

---

Next: [3-usage.md](3-usage.md)
