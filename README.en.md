# 🇰🇷 korea-sovereign-ai

**🌐 Language**: [한국어](README.md) · **English (current)**

> **Korean Sovereign AI local launcher** — Run LG EXAONE / SKT A.X / Upstage Solar on your Mac, fully offline
> Apple Silicon · MLX + Ollama · Auto-install / menu / memory management · Tuned for Mac M5 Pro 24GB

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Apple Silicon](https://img.shields.io/badge/Apple_Silicon-M1%E2%80%93M5-black?logo=apple)](https://www.apple.com/mac/)
[![Ollama](https://img.shields.io/badge/Ollama-supported-green)](https://ollama.com)
[![MLX](https://img.shields.io/badge/MLX-4bit-blue)](https://github.com/ml-explore/mlx)

<table>
<tr>
<td>🔗</td><td><b>GitHub</b></td><td><a href="https://github.com/GoGoComputer/korea-sovereign-ai">github.com/GoGoComputer/korea-sovereign-ai</a></td>
</tr>
<tr>
<td>👤</td><td><b>Lead</b></td><td>Kang Heesung (강희성) · <a href="mailto:mobidicmcn@gmail.com">mobidicmcn@gmail.com</a> · 1600-7542</td>
</tr>
<tr>
<td>🛠️</td><td><b>Maintainer</b></td><td>Park Sungmo (박성모)</td>
</tr>
<tr>
<td>🏢</td><td><b>Affiliation</b></td><td><a href="https://aifighter.io">Mobidic Company Inc. — AI Fighter</a> · <a href="https://mobidicsaju.com">SajuPalja AI</a></td>
</tr>
</table>

> 🆕 **New here / no Mac yet?** Start with **[docs/0-소개.md](docs/0-소개.md)** (Korean concept guide).
> It explains "what Korean Sovereign AI is" and "why we built this" from scratch.

---

## ⚡ 1-Minute Install (for non-developers)

> Open the **Terminal app** (`Cmd + Space` → search "Terminal"), then copy & paste the line below → Enter.

```bash
curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash
```

After install:

```bash
ai-status        # Verify the install
ax "Hello"       # Ask one question
~/korea-ai/launcher.sh   # Open the menu
```

When a new version comes out:

```bash
ai-update        # Update to the latest version with one command
                 # (the launcher menu also auto-notifies you)
```

> 💡 To **also install Solar (13GB)** → `KOREA_AI_MODE=full curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash`

---

## 📂 Layout

```
korea-ai/
├── README.md           Korean README
├── README.en.md        ← this file (English)
├── AUTHORS.md          Authors / company info
├── LICENSE             MIT
├── docs/               (Korean documentation)
│   ├── 0-소개.md        🆕 Concept guide for people without a Mac
│   ├── 1-설명.md        Models / Korean Sovereign AI / hardware
│   ├── 2-설치.md        First-time install guide
│   ├── 3-사용법.md      End-user usage guide
│   └── 4-유지보수.md    Memory / disk / automation
├── launcher.sh          Unified menu (interactive, slash commands)
├── install.sh           Auto-installer (idempotent — skips what's installed)
├── web-install.sh       One-line web installer (used by curl)
├── maintain.sh          Auto-maintenance (cron-installable)
└── bin/                 Shortcut commands (after PATH registration)
    ├── ax, ax-ollama, exaone, exaone-mlx, solar
    ├── ai-status        Check install status
    ├── ai-stop          Force-free memory
    ├── ai-clean         Clean disk caches
    └── ai-update        Update to the latest version
```

## 🚀 Getting Started

First time:
```bash
cd ~/DEV/llmDev/korea-ai
./install.sh              # Interactive install (step-by-step confirmation)
# or
./install.sh --minimal    # EXAONE + A.X only (~5GB, excludes Solar)
./install.sh --yes        # Fully automatic
```

Already installed:
```bash
./launcher.sh             # Open the menu
./launcher.sh /ax         # Chat directly with A.X 4.0
./launcher.sh /help       # Help (includes model descriptions)
```

## 📖 Documentation Guide

> Note: detailed docs are currently Korean-only. See [docs/0-소개.md](docs/0-소개.md) for the most beginner-friendly entry point.

| Audience | Start here | Contents |
|---|---|---|
| **🆕 Newcomers / no Mac** | [docs/0-소개.md](docs/0-소개.md) | What this is, why we built it, sovereign AI concept |
| **First-time users** | [docs/1-설명.md](docs/1-설명.md) | What Korean Sovereign AI is, which model to pick |
| **Installers** | [docs/2-설치.md](docs/2-설치.md) | `install.sh` usage, manual install, troubleshooting |
| **End users** | [docs/3-사용법.md](docs/3-사용법.md) | Menu / slash commands / FAQ / cheat sheet |
| **Operators** | [docs/4-유지보수.md](docs/4-유지보수.md) | Memory management, cron automation, disk cleanup |

## ⚙️ Environment

- Designed for **Mac M5 Pro 24GB unified memory**
- Apple Silicon (4-bit MLX quantization to save memory)
- macOS, Python 3.9, Ollama, mlx-lm

## Models at a Glance

| Command | Model | Maker | Memory | Notes |
|---|---|---|---|---|
| `/exaone` | EXAONE 4.0 1.2B (Ollama) | LG AI Research | ~0.8GB | Lightweight multilingual |
| `/exaone-mlx` | EXAONE 4.0 1.2B (MLX) | LG AI Research | ~0.7GB | ★ Fastest (282 tok/s) |
| `/ax` | A.X 4.0 Light (MLX) | SK Telecom | ~4.5GB | ★ Strong Korean, Apache 2.0 |
| `/solar` | Solar Pro 22B (Ollama) | Upstage | ~13GB | Smartest, MIT |

See [docs/1-설명.md](docs/1-설명.md) for details.

---

## 👥 Authors

| Role | Name | Contact |
|---|---|---|
| 🧭 **Lead** | **Kang Heesung (강희성)** | <mobidicmcn@gmail.com> · 1600-7542 |
| 🛠️ **Maintainer** | **Park Sungmo (박성모)** | GitHub [@GoGoComputer](https://github.com/GoGoComputer) |

**Affiliation**: [Mobidic Company Inc. — AI Fighter](https://aifighter.io)
· Service: [SajuPalja AI](https://mobidicsaju.com) (AI-based Korean fortune-telling)

Full company registration / acknowledgements: **[AUTHORS.md](AUTHORS.md)**

## 📜 License

The scripts and docs in this repo are [MIT License](LICENSE).
Model weights follow the licenses of their respective publishers (LG / SKT / Upstage).

## 🤝 Contributing

Issues and PRs welcome → <https://github.com/GoGoComputer/korea-sovereign-ai/issues>
