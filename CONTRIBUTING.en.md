# 🤝 Contributing Guide

**🌐 Language**: [한국어](CONTRIBUTING.md) · **English (current)**

> **Anyone can contribute, even with zero coding skills.**
> From "found a typo" → "feature ideas" → "adding a screenshot", this guide walks you through it step by step.

---

## 🎯 What kinds of contributions are welcome?

| Difficulty | Type | How |
|---|---|---|
| 🟢 **Easy (0 lines of code)** | Typos, wording, translation, usage reports | Issue, or edit directly on the GitHub website |
| 🟢 **Easy** | "It would be nice if it had X" | Open an issue |
| 🟢 **Easy** | Bug report ("this didn't work for me") | Use the issue template |
| 🟡 **Medium** | Add a new model (e.g. HyperCLOVA X) | PR (see below) |
| 🟡 **Medium** | Improve English translation | PR editing `docs/en/` |
| 🔴 **Hard** | New features / refactors | Discuss in an issue first, then PR |

---

## 🟢 No coding required — 3 easiest contribution methods

### Method ① File an issue — 5 minutes

> **An issue = a written report saying "there's a problem here" or "I'd like X".**
> No coding required. You just need a GitHub account.

1. Go to <https://github.com/GoGoComputer/korea-sovereign-ai/issues>
2. Click **[New issue]** in the top right
3. Choose a template (bug / feature request / question)
4. Write the title and body (Korean or English) → **[Submit new issue]**

**Good issue examples:**
- "On Mac mini M2, `install.sh` can't find ollama (screenshot attached)"
- "Please add EXAONE 7.8B to the supported models"
- "In `docs/0-소개.md`, please standardize 'EXAONE-4.0' vs 'EXAONE 4.0' spacing"

---

### Method ② Edit docs directly on GitHub — 10 minutes

> **Works even if you've never used a terminal or git.** Edit in the browser; PR is auto-created.

1. On <https://github.com/GoGoComputer/korea-sovereign-ai>, click the file you want to fix (e.g. `docs/en/0-intro.md`)
2. Click the **pencil icon ✏️** in the top-right of the file view
3. **(First time)** if "Fork this repository" appears, just click it → a copy is auto-created on your account
4. Edit the text (typos, wording, examples, etc.)
5. Scroll down → **"Propose changes"** or **"Commit changes"**
6. Next screen → **"Create pull request"** → title/description auto-filled → click again
7. Done! A maintainer reviews and merges.

> 💡 This uses GitHub's "Edit in place + Auto-fork + Auto-PR" flow. **No local git install required.**

---

### Method ③ Share usage reports / screenshots

- Open an issue with operational reports like "works great on M3 Pro 18GB (speed: ...)"
- Suggest use cases for the README
- Share Korean Sovereign AI–related references (blog posts, news links)

Such information is hugely helpful to other users.

---

## 🟡 How to send a PR — some dev experience needed

> A PR = a request to "merge my changes into this repo".
> **Method ②** above auto-creates a PR for small edits, but for larger changes (multiple files), the workflow below is more convenient.

### Prerequisites
- A GitHub account
- macOS Terminal
- `git` (install via `xcode-select --install`)

### 6-step workflow

```bash
# 1. On GitHub, click [Fork] in the top right of this repo

# 2. Clone your fork locally
git clone https://github.com/<your-username>/korea-sovereign-ai.git
cd korea-sovereign-ai

# 3. Create a branch (short English name describing the work)
git checkout -b fix/typo-in-intro

# 4. Edit files (in your editor)
code docs/en/0-intro.md

# 5. Commit + push
git add docs/en/0-intro.md
git commit -m "docs: fix typo in 0-intro.md"
git push origin fix/typo-in-intro

# 6. GitHub will show a yellow "Compare & pull request" banner → click it
#    Fill title/body (the PR template fills in automatically) → [Create pull request]
```

---

## 📝 PR writing guide (PULL_REQUEST_TEMPLATE)

When you create a PR, the form from [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) is auto-applied. Tips per section:

### 🎯 What did you change? (What)
- A one-line summary. e.g. "Standardize EXAONE spacing in `docs/0-소개.md`"

### 🤔 Why did you change it? (Why)
- Existing problem + what this PR solves. e.g. "9 places mixed 'EXAONE-4.0' / 'EXAONE 4.0' → unified for readability"

### 🧪 How did you test it? (How tested)
- Code → "Verified `ai-status` passes on M5 Pro 24GB"
- Docs → "Previewed; no broken links/images"
- New model → attach an actual chat screenshot

### 📸 Screenshots (optional)
- Attach captures for UI / terminal output changes (drag-and-drop works)

### ✅ Checklist
- [ ] If it touches a doc that exists in both Korean and English, update both
- [ ] Run `bash -n script.sh` for script changes
- [ ] For big changes, discuss in an issue first

---

## 🌐 KR/EN docs sync rules (important)

This repo **keeps every document in Korean and English at the same depth**.

| If you change | You should also update |
|---|---|
| `README.md` | `README.en.md` |
| `AUTHORS.md` | `AUTHORS.en.md` |
| `docs/00-기초.md` | `docs/en/00-basics.md` |
| `docs/0-소개.md` | `docs/en/0-intro.md` |
| `docs/1-설명.md` | `docs/en/1-overview.md` |
| `docs/2-설치.md` | `docs/en/2-install.md` |
| `docs/3-사용법.md` | `docs/en/3-usage.md` |
| `docs/4-유지보수.md` | `docs/en/4-maintenance.md` |

> 💡 If you only update one side, expect a "please update the other language too" comment before merge.
> Not confident in the other language? Update one side and write "translation help wanted" in the PR body — that's fine.

---

## 🐛 How to write a good bug report

The issue template helps, but the essentials:

```
[Environment]
- Mac model: M5 Pro 24GB
- macOS: 14.5
- Install method: web-install.sh

[Steps to reproduce]
1. Run ./launcher.sh /solar
2. Type "Hello"

[Expected]
A response

[Actual]
"out of memory" error, then exits

[Logs / screenshots]
(paste terminal output or attach a capture)
```

---

## 🆘 If you get stuck

- Ask in [Discussions](https://github.com/GoGoComputer/korea-sovereign-ai/discussions) or open an issue with the `question` label
- Maintainer: [@GoGoComputer](https://github.com/GoGoComputer) (Park Sungmo)
- Email: <mobidicmcn@gmail.com>

---

## 📜 Code of Conduct

Please be respectful. Discrimination, hate, and harassment will be removed immediately.
Everyone helping grow the Korean Sovereign AI ecosystem is welcome.

---

**To first-time contributors**: it's okay if it feels awkward. Even a one-line typo fix is a great contribution. Don't hesitate. 🇰🇷
