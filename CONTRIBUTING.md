# 🤝 기여 가이드 (CONTRIBUTING)

**🌐 Language**: **한국어 (현재)** · [English](CONTRIBUTING.en.md)

> 코드를 한 줄도 못 짜도 **누구나 기여할 수 있습니다.**
> "오타 발견" → "기능 제안" → "사진 한 장 추가" 까지, 단계별로 친절하게 안내합니다.

---

## 🎯 어떤 기여가 환영인가요?

| 난이도 | 기여 종류 | 방법 |
|---|---|---|
| 🟢 **쉬움 (코드 0줄)** | 오타·문구 개선, 번역, 사용 후기 | 이슈 또는 GitHub 웹에서 직접 수정 |
| 🟢 **쉬움** | "이런 기능 있으면 좋겠어요" | 이슈로 의견 남기기 |
| 🟢 **쉬움** | 버그 리포트 ("이렇게 했더니 안 돼요") | 이슈 템플릿 사용 |
| 🟡 **중간** | 새 모델 추가 (예: HyperCLOVA X) | PR (아래 가이드 참조) |
| 🟡 **중간** | 문서 영문 번역 보완 | PR로 docs/en/ 수정 |
| 🔴 **어려움** | 새 기능 / 리팩토링 | 먼저 이슈로 논의 후 PR |

---

## 🟢 코드 못 짜도 OK — 가장 쉬운 기여 방법 3가지

### 방법 ① 이슈(Issue) 남기기 — 5분이면 끝

> **이슈 = "여기 문제가 있어요" / "이런 게 있었으면 해요" 라고 글로 남기는 것.**
> 코드 작성 전혀 필요 없음. GitHub 계정만 있으면 됨.

1. 브라우저에서 → <https://github.com/GoGoComputer/korea-sovereign-ai/issues>
2. 우측 상단 **[New issue]** 버튼 클릭
3. 템플릿(버그 / 기능 제안 / 질문) 중 하나 선택
4. 제목·내용 한국어로 자유롭게 작성 → **[Submit new issue]**

**좋은 이슈 예시:**
- "Mac mini M2에서 install.sh 실행 시 ollama 못 찾음 (스크린샷 첨부)"
- "EXAONE 7.8B 모델도 추가해 주세요"
- "docs/0-소개.md 의 'EXAONE-4.0' → 'EXAONE 4.0' 띄어쓰기 통일 부탁"

---

### 방법 ② GitHub 웹에서 바로 문서 수정 — 10분

> **터미널·git 명령어 하나도 모르는 분도 가능.** 브라우저에서 직접 수정하고 PR까지 자동 생성.

1. <https://github.com/GoGoComputer/korea-sovereign-ai> 에서 고치고 싶은 파일 클릭 (예: `docs/0-소개.md`)
2. 파일 화면 우측 위 **연필 아이콘 ✏️** 클릭
3. **(처음이면)** "Fork this repository" 안내가 뜨면 그냥 클릭 → 자동으로 내 계정에 복사본 생성
4. 텍스트 수정 (오타·문구·예시 추가 등)
5. 화면 아래 **"Propose changes"** 또는 **"Commit changes"** 클릭
6. 다음 화면에서 **"Create pull request"** → 제목/설명 자동 채워짐 → 한 번 더 클릭
7. 끝! 메인테이너가 검토 후 머지

> 💡 이 흐름은 GitHub의 "Edit in place + Auto-fork + Auto-PR" 기능. **로컬에 git 설치도 필요 없음.**

---

### 방법 ③ 사용 후기 / 스크린샷 공유

- 이슈에 "M3 Pro 18GB에서 잘 돌아갑니다 (속도: ...)" 같은 동작 보고
- README에 추가할 만한 사용 사례 제안
- 한국 소버린 AI 관련 자료(블로그·뉴스 링크) 제보

이런 정보는 다른 사용자에게 큰 도움이 됩니다.

---

## 🟡 PR (Pull Request) 보내는 법 — 개발 경험 약간 필요

> PR = "내가 만든 변경사항을 이 레포에 합쳐달라"는 요청.
> 위 **방법 ②**를 쓰면 PR이 자동 생성되지만, 더 큰 변경(여러 파일 수정 등)은 아래 절차가 편합니다.

### 사전 준비
- GitHub 계정
- macOS 터미널
- `git` (`xcode-select --install` 로 설치)

### 6단계 워크플로

```bash
# 1. GitHub 웹에서 이 레포 우측 상단 [Fork] 클릭

# 2. 내 fork 를 로컬에 복제
git clone https://github.com/<내아이디>/korea-sovereign-ai.git
cd korea-sovereign-ai

# 3. 브랜치 생성 (작업명을 영어로 짧게)
git checkout -b fix/typo-in-intro

# 4. 파일 수정 (에디터로)
code docs/0-소개.md

# 5. 커밋 + 푸시
git add docs/0-소개.md
git commit -m "docs: fix typo in 0-소개.md"
git push origin fix/typo-in-intro

# 6. GitHub 으로 가면 "Compare & pull request" 노란 배너가 뜸 → 클릭
#    제목/설명 작성 (PR 템플릿 자동 적용됨) → [Create pull request]
```

---

## 📝 PR 작성 가이드 (PULL_REQUEST_TEMPLATE)

PR을 만들면 [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) 의 양식이 자동으로 채워집니다. 항목별 작성 팁:

### 🎯 무엇을 바꿨나요? (What)
- "한 줄로" 요약. 예: "docs/0-소개.md 의 EXAONE 띄어쓰기 통일"

### 🤔 왜 바꿨나요? (Why)
- "기존 문제" + "이 PR로 해결되는 점". 예: "본문 9곳에서 'EXAONE-4.0' / 'EXAONE 4.0' 혼용 → 가독성 통일"

### 🧪 어떻게 확인했나요? (How tested)
- 코드라면 → "M5 Pro 24GB에서 `ai-status` 통과 확인"
- 문서라면 → "프리뷰로 링크/이미지 깨짐 없음 확인"
- 새 모델 추가라면 → 실제 채팅 스크린샷

### 📸 스크린샷 (선택)
- UI/터미널 출력 변경 시 캡처 첨부 (드래그 앤 드롭 가능)

### ✅ 체크리스트
- [ ] 한국어/영어 둘 다 영향 받는 문서면 둘 다 수정
- [ ] `bash -n script.sh` 로 문법 확인 (스크립트 변경 시)
- [ ] 큰 변경이면 먼저 이슈로 논의

---

## 🌐 한·영 문서 동기화 규칙 (중요)

이 레포는 **모든 문서를 한·영 동일 깊이로 유지**합니다.

| 한국어 변경 | 같이 수정해야 할 영문 |
|---|---|
| `README.md` | `README.en.md` |
| `AUTHORS.md` | `AUTHORS.en.md` |
| `docs/00-기초.md` | `docs/en/00-basics.md` |
| `docs/0-소개.md` | `docs/en/0-intro.md` |
| `docs/1-설명.md` | `docs/en/1-overview.md` |
| `docs/2-설치.md` | `docs/en/2-install.md` |
| `docs/3-사용법.md` | `docs/en/3-usage.md` |
| `docs/4-유지보수.md` | `docs/en/4-maintenance.md` |

> 💡 한 쪽만 수정하면 PR 머지 전에 "영문도 같이 부탁드려요" 코멘트가 달릴 수 있어요.
> 영어가 자신 없으면 → 한국어만 수정 + PR 본문에 "영문은 도움 부탁" 명시 OK.

---

## 🐛 좋은 버그 리포트 작성법

이슈 템플릿이 도와주지만, 핵심:

```
[환경]
- Mac 모델: M5 Pro 24GB
- macOS: 14.5
- 설치 방법: web-install.sh

[재현 단계]
1. ./launcher.sh /solar 실행
2. "안녕" 입력

[기대 동작]
응답이 나옴

[실제 동작]
"out of memory" 에러 후 종료

[로그 / 스크린샷]
(터미널 출력 복붙 또는 캡처)
```

---

## 🆘 막히면

- 질문은 [Discussions](https://github.com/GoGoComputer/korea-sovereign-ai/discussions) 또는 이슈에 `question` 라벨로
- 메인테이너: [@GoGoComputer](https://github.com/GoGoComputer) (박성모)
- 메일: <mobidicmcn@gmail.com>

---

## 📜 행동 강령 (Code of Conduct)

서로 존중합시다. 차별·혐오·괴롭힘은 즉시 차단됩니다.
한국 소버린 AI 생태계를 함께 키워나가는 분들 모두 환영합니다.

---

**처음 기여하시는 분께**: 어색해도 괜찮습니다. 오타 수정 한 줄도 훌륭한 기여예요. 부담 없이 시작하세요. 🇰🇷
