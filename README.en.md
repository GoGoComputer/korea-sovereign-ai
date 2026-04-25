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
>
> 🕰️ **"What even *is* a local LLM?"** → **[docs/en/00-basics.md](docs/en/00-basics.md)** (every term — token, quantization, Ollama, MLX — explained from zero).

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
├── CONTRIBUTING.md     🤝 Contributing guide (Korean)
├── CONTRIBUTING.en.md  🤝 Contributing guide (English, beginner-friendly)
├── LICENSE             MIT
├── .github/            PR / Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── ISSUE_TEMPLATE/  (bug / feature / question)
├── docs/               (documentation — Korean originals + English mirror)
│   ├── 00-기초.md / en/00-basics.md         🕰️ Absolute basics
│   ├── A1-개념사전.md / en/A1-glossary.md   📖 Concepts dictionary
│   ├── A2-수동설치.md / en/A2-manual-install.md  🔧 Fully manual install
│   ├── 0-소개.md / en/0-intro.md
│   ├── 1-설명.md / en/1-overview.md
│   ├── 2-설치.md / en/2-install.md
│   ├── 3-사용법.md / en/3-usage.md
│   └── 4-유지보수.md / en/4-maintenance.md
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

| Audience | Start here | Contents |
|---|---|---|
| **🕰️ Absolute beginners (what's a local LLM?)** | [docs/en/00-basics.md](docs/en/00-basics.md) | LLM / token / quantization / Ollama / MLX from zero |
| **📖 Glossary / concepts** | [docs/en/A1-glossary.md](docs/en/A1-glossary.md) | Terminal / folder / Hugging Face / Ollama / MLX — "what is that?" reference |
| **🔧 Fully manual install** | [docs/en/A2-manual-install.md](docs/en/A2-manual-install.md) | Do everything `install.sh` automates, by hand |
| **🆕 Newcomers / no Mac** | [docs/en/0-intro.md](docs/en/0-intro.md) | What this is, why we built it, sovereign AI concept |
| **First-time users** | [docs/en/1-overview.md](docs/en/1-overview.md) | What Korean Sovereign AI is, which model to pick |
| **Installers** | [docs/en/2-install.md](docs/en/2-install.md) | `install.sh` usage, manual install, troubleshooting |
| **End users** | [docs/en/3-usage.md](docs/en/3-usage.md) | Menu / slash commands / FAQ / cheat sheet |
| **Operators** | [docs/en/4-maintenance.md](docs/en/4-maintenance.md) | Memory management, cron automation, disk cleanup |

> Korean originals are in [`docs/`](docs/).

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

**You can contribute even with zero coding skills!** Step-by-step guides:

| Difficulty | What you do | Doc |
|---|---|---|
| 🟢 Typo / wording fix, usage report | Just open an issue | [CONTRIBUTING.en.md](CONTRIBUTING.en.md) · Method ① |
| 🟢 Edit docs in the browser | No git needed; PR auto-created | [CONTRIBUTING.en.md](CONTRIBUTING.en.md) · Method ② |
| 🟡 Add a model / feature (PR) | Fork → branch → PR | [CONTRIBUTING.en.md](CONTRIBUTING.en.md) · 6-step workflow |

**Links**
- 📖 [Contributing Guide (CONTRIBUTING.en.md)](CONTRIBUTING.en.md) — 3 non-developer paths + PR walkthrough
- 📝 [PR template](.github/PULL_REQUEST_TEMPLATE.md) — auto-filled when you open a PR
- 🐛 [Open an issue](https://github.com/GoGoComputer/korea-sovereign-ai/issues/new/choose) — bug / feature / question templates
- 💬 [Discussions](https://github.com/GoGoComputer/korea-sovereign-ai/discussions)

> A first issue, a one-line typo fix — those are great contributions. Don't hesitate to start. 🇩🇰
