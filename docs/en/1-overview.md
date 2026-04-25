# 1. Overview — Korean Sovereign AI Lineup

**🌐 Language**: [한국어](../1-설명.md) · **English (current)**

## 🇰🇷 What is Korean Sovereign AI?

**Sovereign AI** = AI models built by domestic Korean companies and research institutes.
- Data does not leave the country
- Best understanding of the Korean language
- Core candidates of the government's **"Independent AI Foundation Model (Dokpamo)"** initiative (2025~)

This setup configures the three flagship Korean models so you can **run all of them locally on a single Mac M5 Pro 24GB**.

---

## 🖥️ Hardware Requirements

This package is designed around **Mac M5 Pro 24GB unified memory**.

| Item | Recommended | Minimum |
|---|---|---|
| Chip | Apple Silicon (M2 Pro or later) | Apple Silicon |
| Unified memory | 24GB | 16GB (excluding Solar) |
| Free disk | 25GB+ | 6GB (`--minimal`) |
| OS | macOS 14+ | macOS 13+ |

> 💡 **Tip for 24GB systems**: when running Solar (13GB), close heavy apps like Chrome / Slack / VS Code. EXAONE/A.X are fine for everyday work.

> ❌ **Intel Mac / under 16GB**: MLX won't work, or Solar will swap heavily and become very slow. Use `--minimal` to install only EXAONE+A.X.

---

## 📚 Model Details

### 【 EXAONE 4.0 1.2B 】  LG AI Research

- **Full name**: EXpert Ai for EveryONE 4.0
- **Maker**: LG AI Research (Korea, founded 2020)
- **License**: EXAONE AI Model License (free for research; commercial requires separate terms)
- **Training**: LG's own supercomputer + Korean / English / Spanish multilingual data
- **Highlights**:
  - Core of LG Group's enterprise-wide AI strategy (tuned for home appliances, chemicals, telecom)
  - 4.0 generation lineup is 1.2B / 7.8B / 32B — even the small size has excellent Korean quality
  - A candidate for the government's **Dokpamo** initiative
- **Memory in this setup**: Ollama Q4_K_M ~0.8GB / MLX 4-bit ~0.7GB
- **Speed**: **282 tok/s** on M5 Pro MLX 4-bit (measured)

### 【 SKT A.X 4.0 Light 】  SK Telecom

- **Full name**: Adaptive eXperience 4.0 (Light variant)
- **Training infra**: SKT's own supercomputer **TITAN** (1,000+ NVIDIA H100 GPUs)
- **License**: **Apache 2.0** (the most permissive among Korean sovereign models; commercial OK)
- **Context**: 32K (native) / 131K (extended via YaRN)
- **Highlights**:
  - Custom Korean tokenizer → **33% fewer Korean tokens** vs. GPT-4o
    (= longer Korean text at the same cost + faster responses)
  - **KMMLU 69.2** (top of its class on the Korean comprehensive benchmark)
  - Domain-tuned with SKT telecom & customer-service data → excels at real-world Korean
  - Core candidate of the government's **Dokpamo** initiative
- **Memory in this setup**: MLX 4-bit ~4.5GB (original BF16 14GB)
- **Speed**: ~65 tok/s on M5 Pro (measured, peak 4.16GB)

### 【 Solar Pro Preview 22B 】  Upstage

- **Maker**: Upstage (Korean startup)
- **License**: **MIT** (most permissive)
- **Parameters**: 22B dense — efficient scaling via "Depth Up-Scaling (DUS)"
- **Highlights**:
  - Achieves 70B-class reasoning performance with 22B (per Upstage's own benchmarks)
  - A globally competitive model from a Korean startup
  - Strong in both English and Korean; balanced code/math
  - "Preview" — a public preview of the official Solar Pro (109B)
- **Memory in this setup**: Ollama Q4_K_M ~13GB
- ⚠ On 24GB RAM: recommended to close other heavy apps before running

---

## 🎯 Which model should I pick?

| Situation | Recommendation |
|---|---|
| Korean email / docs / everyday questions | `/ax` (SKT) |
| Quick short answers / summaries | `/exaone-mlx` (LG, MLX) |
| Hard reasoning / coding / translation | `/solar` (Upstage) |
| Not sure | Start with `/ax` |

---

## 🌏 Korean Sovereign AI Policy Context

Candidates for the **Independent AI Foundation Model (Dokpamo)** initiative (2025~):
- LG AI Research — **EXAONE**
- SK Telecom — **A.X**
- Naver — HyperCLOVA X (not publicly released)
- Upstage — **Solar** (going global)
- NCSOFT, KT, Kakao, etc.

This package covers the three models with **publicly available weights**: EXAONE / A.X / Solar.

---

Next: [2-install.md](2-install.md)
