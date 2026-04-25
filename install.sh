#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  korea-ai/install.sh — 한국 소버린 AI 자동 설치 (Mac M5 Pro 24GB)
# ─────────────────────────────────────────────────────────────────────────────
#  하는 일 (멱등 — 이미 깔린 건 건너뜀):
#   1) PATH 등록 (이 폴더의 bin/ 을 ~/.zshrc 에 추가)
#   2) Python 의존성 (mlx-lm, huggingface_hub) 설치 확인
#   3) Ollama 동작 확인 (없으면 안내)
#   4) EXAONE 4.0 1.2B (Ollama Q4_K_M) pull   — 약 0.8GB
#   5) EXAONE 4.0 1.2B (MLX 4bit) 변환         — 약 0.7GB
#   6) SKT A.X 4.0 Light (MLX 4bit) 변환       — 약 4.5GB (BF16 14GB 다운로드 필요)
#   7) Solar Pro 22B GGUF 다운로드 + Ollama 등록 — 약 13GB
#   8) (옵션) 주간 자동 유지보수 cron 등록
#
#  Usage:
#    ./install.sh              # 대화형 (각 단계 확인)
#    ./install.sh --yes        # 모두 자동 진행
#    ./install.sh --minimal    # EXAONE + A.X 만 (가벼움, 5GB)
#    ./install.sh --check      # 상태만 확인 (설치 안 함)
# ─────────────────────────────────────────────────────────────────────────────
set -u

YES=0
MINIMAL=0
CHECK_ONLY=0
for arg in "$@"; do
  case "$arg" in
    --yes|-y)    YES=1 ;;
    --minimal)   MINIMAL=1 ;;
    --check)     CHECK_ONLY=1 ;;
    -h|--help)
      sed -n '2,22p' "$0"; exit 0 ;;
  esac
done

HERE="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HERE/bin"
MODELS="$HOME/models"
EXAONE_OLLAMA="hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M"
EXAONE_MLX_DIR="$MODELS/exaone-4.0-1.2b-4bit-mlx"
EXAONE_MLX_HF="LGAI-EXAONE/EXAONE-4.0-1.2B"
AX_MLX_DIR="$MODELS/ax-4.0-light-4bit-mlx"
AX_HF="skt/A.X-4.0-Light"
SOLAR_DIR="$MODELS/solar-pro"
SOLAR_GGUF="$SOLAR_DIR/solar-pro-preview-instruct.Q4_K_M.gguf"
SOLAR_HF_REPO="MaziyarPanahi/solar-pro-preview-instruct-GGUF"
SOLAR_HF_FILE="solar-pro-preview-instruct.Q4_K_M.gguf"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# ─── 헬퍼 ────────────────────────────────────────────────────────────────────
ok()    { printf "\033[32m✓\033[0m %s\n" "$*"; }
warn()  { printf "\033[33m⚠\033[0m %s\n" "$*"; }
err()   { printf "\033[31m✗\033[0m %s\n" "$*"; }
step()  { printf "\n\033[1;36m▶ %s\033[0m\n" "$*"; }

ask() {
  [[ "$YES" -eq 1 ]] && return 0
  read -rp "  → 진행할까요? [Y/n] " a
  [[ -z "$a" || "$a" =~ ^[Yy]$ ]]
}

dir_has_model() {
  [[ -f "$1/config.json" && -f "$1/model.safetensors" || -f "$1/model.safetensors.index.json" ]]
}

ollama_has() {
  ollama list 2>/dev/null | awk '{print $1}' | grep -q "^${1}\(:.*\)\?$"
}

# ─── 0) 환경 점검 ────────────────────────────────────────────────────────────
step "0) 환경 점검 (Mac M5 Pro 24GB 권장)"
uname -m | grep -q arm64 && ok "Apple Silicon" || warn "ARM64 가 아님 (MLX 동작 안 함)"
mem_gb=$(sysctl -n hw.memsize 2>/dev/null | awk '{print int($1/1024/1024/1024)}')
if [[ "${mem_gb:-0}" -lt 16 ]]; then
  warn "메모리 ${mem_gb}GB — Solar(13GB) 실행 어려움. --minimal 권장"
else
  ok "메모리 ${mem_gb}GB"
fi

# ─── 1) PATH 등록 ────────────────────────────────────────────────────────────
step "1) PATH 등록"
RC="$HOME/.zshrc"
LINE="export PATH=\"$BIN_DIR:\$PATH\"  # korea-ai launchers"
if grep -Fq "$BIN_DIR" "$RC" 2>/dev/null; then
  ok "이미 등록됨: $BIN_DIR"
else
  if [[ "$CHECK_ONLY" -eq 0 ]]; then
    printf '\n# korea-ai launchers\n%s\n' "$LINE" >> "$RC"
    ok "$RC 에 PATH 추가됨"
    warn "새 터미널을 열거나: source ~/.zshrc"
  else
    warn "(check) 미등록"
  fi
fi
chmod +x "$BIN_DIR"/* "$HERE/launcher.sh" 2>/dev/null || true

# ─── 2) 의존성 ───────────────────────────────────────────────────────────────
step "2) Python 의존성"
if python3 -c "import mlx_lm" 2>/dev/null; then
  ok "mlx-lm 설치됨"
else
  warn "mlx-lm 없음"
  if [[ "$CHECK_ONLY" -eq 0 ]]; then
    if ask; then python3 -m pip install --user mlx-lm; fi
  fi
fi
if command -v huggingface-cli >/dev/null; then
  ok "huggingface-cli 설치됨"
else
  warn "huggingface-cli 없음"
  if [[ "$CHECK_ONLY" -eq 0 ]]; then
    if ask; then python3 -m pip install --user huggingface_hub; fi
  fi
fi

# ─── 3) Ollama ───────────────────────────────────────────────────────────────
step "3) Ollama"
if command -v ollama >/dev/null; then
  ok "ollama 설치됨 ($(ollama --version 2>/dev/null | head -1))"
  if curl -s http://localhost:11434/api/tags >/dev/null 2>&1; then
    ok "ollama 서버 응답 OK"
  else
    warn "서버 미실행 — Ollama.app 실행 또는 'ollama serve &'"
  fi
else
  err "ollama 미설치 — https://ollama.com/download 에서 설치 후 다시 실행"
  [[ "$CHECK_ONLY" -eq 0 ]] && exit 1
fi

[[ "$CHECK_ONLY" -eq 1 ]] && { echo; echo "(--check 모드) 종료"; exit 0; }

mkdir -p "$MODELS"

# ─── 4) EXAONE Ollama ────────────────────────────────────────────────────────
step "4) EXAONE 4.0 1.2B (Ollama, ~0.8GB)"
if ollama_has "$EXAONE_OLLAMA"; then
  ok "이미 등록됨"
else
  if ask; then ollama pull "$EXAONE_OLLAMA" && ok "완료" || err "실패"; fi
fi

# ─── 5) EXAONE MLX ───────────────────────────────────────────────────────────
step "5) EXAONE 4.0 1.2B (MLX 4bit, ~0.7GB)"
if dir_has_model "$EXAONE_MLX_DIR"; then
  ok "이미 변환됨: $EXAONE_MLX_DIR"
else
  if ask; then
    python3 -m mlx_lm convert --hf-path "$EXAONE_MLX_HF" --mlx-path "$EXAONE_MLX_DIR" -q \
      && ok "완료" || err "실패"
  fi
fi

# ─── 6) A.X MLX ──────────────────────────────────────────────────────────────
step "6) SKT A.X 4.0 Light (MLX 4bit, ~4.5GB / BF16 14GB 다운로드 필요)"
if dir_has_model "$AX_MLX_DIR"; then
  ok "이미 변환됨: $AX_MLX_DIR"
else
  if ask; then
    python3 -m mlx_lm convert --hf-path "$AX_HF" --mlx-path "$AX_MLX_DIR" -q \
      && ok "완료" || err "실패"
  fi
fi

# ─── 7) Solar Pro ────────────────────────────────────────────────────────────
if [[ "$MINIMAL" -eq 1 ]]; then
  step "7) Solar Pro 22B — --minimal 모드라 건너뜀"
else
  step "7) Solar Pro 22B (Ollama, ~13GB)"
  if ollama_has "solar-pro"; then
    ok "이미 등록됨"
  else
    if [[ -f "$SOLAR_GGUF" ]]; then
      ok "GGUF 존재 → Ollama 등록만 진행"
      if ask; then
        mf=$(mktemp -t solar-modelfile.XXXX)
        echo "FROM $SOLAR_GGUF" > "$mf"
        ollama create solar-pro -f "$mf" && ok "완료" || err "실패"
        rm -f "$mf"
      fi
    else
      warn "GGUF 다운로드 필요 (~13GB, 시간 소요)"
      if ask; then
        mkdir -p "$SOLAR_DIR"
        huggingface-cli download "$SOLAR_HF_REPO" --include "$SOLAR_HF_FILE" --local-dir "$SOLAR_DIR" \
          && {
            mf=$(mktemp -t solar-modelfile.XXXX)
            echo "FROM $SOLAR_GGUF" > "$mf"
            ollama create solar-pro -f "$mf" && ok "완료" || err "Ollama 등록 실패"
            rm -f "$mf"
          } || err "다운로드 실패"
      fi
    fi
  fi
fi

# ─── 8) 자동 유지보수 cron (옵션) ────────────────────────────────────────────
step "8) 주간 자동 유지보수 (선택)"
MAINT="$HERE/maintain.sh"
CRON_LINE="0 4 * * 0 $MAINT --auto >> $HOME/.korea-ai-maint.log 2>&1"
if crontab -l 2>/dev/null | grep -Fq "$MAINT"; then
  ok "cron 이미 등록됨 (매주 일요일 04:00)"
else
  echo "  매주 일요일 04:00 에 자동 정리(메모리/캐시) 등록할까요?"
  if ask; then
    (crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
    ok "cron 등록 완료"
  fi
fi

echo
echo "═══════════════════════════════════════════════════"
echo " 설치 완료. 사용:"
echo "   $HERE/launcher.sh         # 메뉴"
echo "   source ~/.zshrc           # PATH 적용 (새 터미널이면 불필요)"
echo "   ax \"안녕\"                # A.X 4.0 단발 호출"
echo "   ai-status                 # 상태 점검"
echo "   ai-update                 # 최신 버전 업데이트 (한 줄)"
echo "   $HERE/maintain.sh         # 수동 유지보수"
echo "═══════════════════════════════════════════════════"
