# 🇰🇷 korea-sovereign-ai

> **한국 소버린 AI 로컬 런처** — LG EXAONE / SKT A.X / Upstage Solar 를 인터넷 없이 맥북에서 실행
> Apple Silicon · MLX + Ollama · 자동 설치 / 메뉴 / 메모리 관리 · Mac M5 Pro 24GB 최적화

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Apple Silicon](https://img.shields.io/badge/Apple_Silicon-M1%E2%80%93M5-black?logo=apple)](https://www.apple.com/mac/)
[![Ollama](https://img.shields.io/badge/Ollama-supported-green)](https://ollama.com)
[![MLX](https://img.shields.io/badge/MLX-4bit-blue)](https://github.com/ml-explore/mlx)

<table>
<tr>
<td>🔗</td><td><b>GitHub</b></td><td><a href="https://github.com/GoGoComputer/korea-sovereign-ai">github.com/GoGoComputer/korea-sovereign-ai</a></td>
</tr>
<tr>
<td>👤</td><td><b>대표 (Lead)</b></td><td>강희성 (Kang Heesung) · <a href="mailto:mobidicmcn@gmail.com">mobidicmcn@gmail.com</a> · 1600-7542</td>
</tr>
<tr>
<td>🛠️</td><td><b>개발 (Maintainer)</b></td><td>박성모 (Park Sungmo)</td>
</tr>
<tr>
<td>🏢</td><td><b>소속</b></td><td><a href="https://aifighter.io">주식회사 모비딕컴퍼니 — AI Fighter</a> · <a href="https://mobidicsaju.com">사주팔자AI</a></td>
</tr>
</table>

> 🆕 **처음 보는 분 / 맥북 없는 분**도 → **[docs/0-소개.md](docs/0-소개.md)** 부터 읽어보세요.
> "한국 소버린 AI가 뭔지", "왜 만들었는지" 부터 친절하게 설명합니다.

---

## ⚡ 1분 설치 (비개발자용)

> **터미널 앱**(`Cmd + Space` → "터미널" 검색)을 열고 아래 한 줄을 복사·붙여넣기 → Enter.

```bash
curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash
```

설치 후 사용:

```bash
ai-status        # 잘 설치됐는지 확인
ax "안녕하세요"   # 한 번 질문해보기
~/korea-ai/launcher.sh   # 메뉴 (또는 그냥: korea-ai-menu — 새 터미널에서)
```

나중에 새 버전이 나오면:

```bash
ai-update        # 한 줄로 최신 버전 업데이트 (런처 메뉴에도 자동 알림)
```

> 💡 **Solar(13GB)도 같이 설치**하려면 → `KOREA_AI_MODE=full curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash`

---


## 📂 구성

```
korea-ai/
├── README.md           ← 지금 이 파일 (인덱스)
├── AUTHORS.md          저자 / 회사 정보
├── LICENSE             MIT
├── docs/
│   ├── 0-소개.md        🆕 맥 없는 사람도 이해하는 개념 가이드
│   ├── 1-설명.md        모델 / 한국 소버린 AI / 하드웨어 안내
│   ├── 2-설치.md        처음 설치 가이드
│   ├── 3-사용법.md      일반 사용자용 사용 가이드
│   └── 4-유지보수.md    메모리 / 디스크 / 자동화
├── launcher.sh          통합 메뉴 (대화형, 슬래시 명령)
├── install.sh           자동 설치 (멱등 — 이미 깔린 건 skip)
├── maintain.sh          자동 유지보수 (cron 등록 가능)
└── bin/                 단축 명령 (PATH 등록 후 어디서나)
    ├── ax, ax-ollama, exaone, exaone-mlx, solar
    ├── ai-status        설치 상태 점검
    ├── ai-stop          메모리 강제 정리
    └── ai-clean         디스크 캐시 정리
```

## 🚀 시작하기

처음이면:
```bash
cd ~/DEV/llmDev/korea-ai
./install.sh              # 대화형 설치 (단계별 확인)
# 또는
./install.sh --minimal    # EXAONE + A.X 만 (~5GB, Solar 제외)
./install.sh --yes        # 모두 자동 진행
```

이미 설치돼 있다면:
```bash
./launcher.sh             # 메뉴 진입
./launcher.sh /ax         # A.X 4.0 바로 채팅
./launcher.sh /help       # 도움말 (모델 설명 포함)
```

## 📖 문서 가이드

| 누구 | 어디부터 | 내용 |
|---|---|---|
| **🆕 처음 보는 사람 / 맥 없는 분** | [docs/0-소개.md](docs/0-소개.md) | 이게 뭔지, 왜 만들었는지, 소버린 AI 개념 |
| **처음 사용자** | [docs/1-설명.md](docs/1-설명.md) | 한국 소버린 AI가 뭔지, 어느 모델 골라야 하는지 |
| **셋업할 사람** | [docs/2-설치.md](docs/2-설치.md) | install.sh 사용법, 수동 설치, 트러블슈팅 |
| **일반 사용자** | [docs/3-사용법.md](docs/3-사용법.md) | 메뉴 / 슬래시 명령 / FAQ / 한 장 요약 |
| **관리자** | [docs/4-유지보수.md](docs/4-유지보수.md) | 메모리 관리, cron 자동화, 디스크 정리 |

## ⚙️ 환경

- **Mac M5 Pro 24GB 통합 메모리** 기준으로 설계
- Apple Silicon (MLX 4bit 양자화로 메모리 절약)
- macOS, Python 3.9, Ollama, mlx-lm

## 모델 한 줄 비교

| 명령 | 모델 | 만든 곳 | 메모리 | 특징 |
|---|---|---|---|---|
| `/exaone` | EXAONE 4.0 1.2B (Ollama) | LG AI연구원 | ~0.8GB | 가벼운 멀티링구얼 |
| `/exaone-mlx` | EXAONE 4.0 1.2B (MLX) | LG AI연구원 | ~0.7GB | ★ 가장 빠름 (282 tok/s) |
| `/ax` | A.X 4.0 Light (MLX) | SK텔레콤 | ~4.5GB | ★ 한국어 강세, Apache 2.0 |
| `/solar` | Solar Pro 22B (Ollama) | Upstage | ~13GB | 가장 똑똑함, MIT |

상세는 [docs/1-설명.md](docs/1-설명.md) 참조.

---

## � 만든 사람

| 역할 | 이름 | 연락처 |
|---|---|---|
| 🧭 **대표 (Lead)** | **강희성 (Kang Heesung)** | <mobidicmcn@gmail.com> · 1600-7542 |
| 🛠️ **개발 (Maintainer)** | **박성모 (Park Sungmo)** | GitHub [@GoGoComputer](https://github.com/GoGoComputer) |

**소속**: [주식회사 모비딕컴퍼니 — AI Fighter](https://aifighter.io)
· 서비스: [사주팔자AI](https://mobidicsaju.com) (AI 기반 운세 분석)

상세 회사 등록 정보 / 감사 인사: **[AUTHORS.md](AUTHORS.md)**

## 📜 라이선스

이 레포의 스크립트·문서는 [MIT License](LICENSE).
모델 가중치는 각 배포처(LG / SKT / Upstage)의 라이선스를 따릅니다.

## 🤝 기여

이슈·PR 환영합니다 → <https://github.com/GoGoComputer/korea-sovereign-ai/issues>
