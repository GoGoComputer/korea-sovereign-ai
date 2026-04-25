#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  korea-ai/web-install.sh — 한 줄 웹 설치
# ─────────────────────────────────────────────────────────────────────────────
#  비개발자도 한 줄이면 OK:
#
#    curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash
#
#  하는 일:
#   1) git / Xcode CLT 확인 (없으면 안내)
#   2) ~/korea-ai 에 git clone (이미 있으면 git pull 로 최신화)
#   3) install.sh 자동 실행 (--minimal 기본 = EXAONE + A.X 약 5GB)
#   4) 끝나면 "터미널 새로 열고 launcher 입력" 안내
#
#  옵션 (환경변수):
#    KOREA_AI_DIR=경로     설치 위치 (기본 ~/korea-ai)
#    KOREA_AI_MODE=full    full=Solar 포함 (~18GB), minimal=기본 (~5GB),
#                          check=상태만 확인
#    KOREA_AI_BRANCH=main  설치할 git 브랜치
# ─────────────────────────────────────────────────────────────────────────────
set -u

REPO_URL="https://github.com/GoGoComputer/korea-sovereign-ai.git"
DIR="${KOREA_AI_DIR:-$HOME/korea-ai}"
MODE="${KOREA_AI_MODE:-minimal}"
BRANCH="${KOREA_AI_BRANCH:-main}"

ok()   { printf "\033[32m✓\033[0m %s\n" "$*"; }
warn() { printf "\033[33m⚠\033[0m %s\n" "$*"; }
err()  { printf "\033[31m✗\033[0m %s\n" "$*" >&2; }
step() { printf "\n\033[1;36m▶ %s\033[0m\n" "$*"; }

cat <<'BANNER'

══════════════════════════════════════════════════════════════════════
 🇰🇷 Korean Sovereign AI — 한 줄 설치
   LG EXAONE · SKT A.X · Upstage Solar 를 맥북에서 인터넷 없이
══════════════════════════════════════════════════════════════════════

BANNER

# ─── 0) 운영체제 확인 ────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  err "이 도구는 macOS 전용입니다 (현재: $(uname))"
  exit 1
fi
if [[ "$(uname -m)" != "arm64" ]]; then
  warn "Apple Silicon(M1~M5) 이 아닙니다. MLX 모델은 동작하지 않을 수 있어요."
fi

# ─── 1) git 확인 ─────────────────────────────────────────────────────────────
step "1) git 확인"
if ! command -v git >/dev/null 2>&1; then
  warn "git 이 없네요. Apple 'Command Line Tools' 가 필요합니다."
  echo "  → 아래 창이 뜨면 [설치] 버튼을 누르고 5~10분 기다린 뒤 다시 실행하세요."
  xcode-select --install 2>/dev/null || true
  err "설치가 끝나면 다음 명령을 다시 실행하세요:"
  echo "    curl -fsSL https://raw.githubusercontent.com/GoGoComputer/korea-sovereign-ai/main/web-install.sh | bash"
  exit 1
fi
ok "git: $(git --version)"

# ─── 2) clone 또는 pull ─────────────────────────────────────────────────────
step "2) 소스 받기 → $DIR"
if [[ -d "$DIR/.git" ]]; then
  ok "이미 있음 → 최신 버전으로 업데이트"
  git -C "$DIR" fetch --quiet origin "$BRANCH" || warn "fetch 실패 (네트워크?)"
  git -C "$DIR" checkout --quiet "$BRANCH" || true
  git -C "$DIR" pull --ff-only --quiet origin "$BRANCH" \
    && ok "업데이트 완료" \
    || warn "pull 실패 — 로컬 변경사항이 있을 수 있어요. 그대로 진행합니다."
elif [[ -e "$DIR" ]]; then
  err "$DIR 이 이미 존재하지만 git 저장소가 아닙니다."
  err "다른 위치에 설치하려면:  KOREA_AI_DIR=~/다른경로 bash <(curl -fsSL ...)"
  exit 1
else
  mkdir -p "$(dirname "$DIR")"
  git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$DIR" \
    && ok "clone 완료" \
    || { err "clone 실패 (네트워크 확인)"; exit 1; }
fi

chmod +x "$DIR"/*.sh "$DIR"/bin/* 2>/dev/null || true

# ─── 3) install.sh 실행 ──────────────────────────────────────────────────────
step "3) 설치 실행 (모드: $MODE)"
case "$MODE" in
  full)    bash "$DIR/install.sh" --yes ;;
  minimal) bash "$DIR/install.sh" --yes --minimal ;;
  check)   bash "$DIR/install.sh" --check ;;
  *)       err "알 수 없는 모드: $MODE (full|minimal|check)"; exit 1 ;;
esac

# ─── 4) 끝맺음 안내 ──────────────────────────────────────────────────────────
cat <<EOF

══════════════════════════════════════════════════════════════════════
 ✅ 설치 끝났습니다!
══════════════════════════════════════════════════════════════════════

 다음에 할 일 (그대로 복사해서 붙여넣으세요):

   1) 터미널을 한 번 새로 열거나:
        source ~/.zshrc

   2) 메뉴 실행:
        $DIR/launcher.sh
      또는 (PATH 등록 후):
        ax "안녕하세요"           # 한 번만 질문
        ai-status                  # 설치 상태 확인
        ai-update                  # 나중에 업데이트할 때

 문제가 생기면:
   • 도움말:  $DIR/launcher.sh /help
   • 문서:    $DIR/docs/2-설치.md
   • 이슈:    https://github.com/GoGoComputer/korea-sovereign-ai/issues

EOF
