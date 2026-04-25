# 4. Maintenance (Automation)

**🌐 Language**: [한국어](../4-유지보수.md) · **English (current)**

## At a glance

| Task | Command | When |
|---|---|---|
| Force-free memory | `./launcher.sh /unload` or `ai-stop` | Before running other heavy apps |
| Clean disk caches | `ai-clean` | Once a month |
| Deep cleanup (incl. HF cache) | `./maintain.sh --deep` | When disk is low |
| Status check | `ai-status` | When something looks off |
| **Automatic (cron)** | Registered by `./install.sh` | One-time setup |

---

## Manual maintenance

### 1) Free memory
```bash
./launcher.sh /unload          # In the menu: > /unload
ai-stop                         # From anywhere
ai-stop --server                # Also stop the Ollama server (full release)
```

### 2) Disk cleanup (safe)
```bash
ai-clean                        # Delete only temp / lock files (models preserved)
ai-clean --dry-run              # Preview only
ai-clean --hf-cache             # Also delete the HF cache (~13GB BF16 originals)
                                # Converted models in ~/models/ stay safe
```

### 3) Unified maintenance
```bash
./maintain.sh                  # Interactive (asks before each step)
./maintain.sh --status         # Check only, no changes
./maintain.sh --deep           # Includes HF cache deletion
```

What `maintain.sh` does:
1. Unload Ollama models currently in memory
2. Kill any lingering mlx processes
3. If Solar GGUF is downloaded but not registered with Ollama → auto-register
4. Delete `*.incomplete`, `*.lock`, `*.tmp` from model folders
5. (`--deep`) delete the HF cache
6. Disk / memory report

---

## Automation (cron)

### Registered during install
The last step of `./install.sh` asks whether to register it.

### Manual registration
```bash
crontab -e
# Add this line (every Sunday at 04:00)
0 4 * * 0 /Users/mo/DEV/llmDev/korea-ai/maintain.sh --auto >> ~/.korea-ai-maint.log 2>&1
```

### Verify registration
```bash
crontab -l | grep maintain
tail -20 ~/.korea-ai-maint.log
```

### Unregister
```bash
crontab -l | grep -v maintain.sh | crontab -
```

> 💡 The cron `--auto` mode **only frees memory**, preserving the HF cache (predictable + safe).

---

## Monitoring

### What's currently in memory
```bash
./launcher.sh /ps
# or
ollama ps
```

### Disk usage
```bash
du -sh ~/models/*/
ai-status
```

### System memory
```bash
vm_stat | grep "Pages active\|Pages wired"
# or use Activity Monitor in the menu bar
```

### cron log
```bash
tail -f ~/.korea-ai-maint.log
```

---

## Updating models

### Ollama models
```bash
ollama pull hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
ollama pull solar-pro                                          # (re-register via install.sh)
```

### MLX models (re-conversion)
```bash
rm -rf ~/models/ax-4.0-light-4bit-mlx
./install.sh                    # Detects missing → re-converts
```

### When new model lineups appear
- When EXAONE 7.8B / 32B drop, add a new path under `~/models/` and a shortcut like `bin/exaone7b`
- When the official A.X 4.0 lands, re-convert with `--hf-path skt/A.X-4.0`

---

## Backup / Restore

### Back up the models
```bash
# Copy to an external disk (so you don't have to redownload)
rsync -av --progress ~/models/ /Volumes/Backup/models/
```

### Move to another Mac
```bash
# Old Mac
rsync -av ~/models/ user@new-mac:~/models/
rsync -av ~/DEV/llmDev/korea-ai/ user@new-mac:~/DEV/llmDev/korea-ai/

# New Mac
cd ~/DEV/llmDev/korea-ai
./install.sh --check            # Models already there → only PATH/cron get registered
source ~/.zshrc
ai-status
```

### About Ollama models
They live under `~/.ollama/models/`. Back this up too and you don't need to re-pull.

---

## Complete uninstall

```bash
# 1. Free memory
ai-stop --server

# 2. Remove cron
crontab -l | grep -v maintain.sh | crontab -

# 3. Remove PATH registration
sed -i '' '/korea-ai/d' ~/.zshrc

# 4. Delete models
rm -rf ~/models/exaone-4.0-1.2b-4bit-mlx
rm -rf ~/models/ax-4.0-light-4bit-mlx
rm -rf ~/models/solar-pro
ollama rm hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M
ollama rm solar-pro

# 5. (Optional) delete the folder itself
rm -rf ~/DEV/llmDev/korea-ai
```

---

Previous: [3-usage.md](3-usage.md)
