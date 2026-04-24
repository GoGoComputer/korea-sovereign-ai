#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  korea-ai/maintain.sh — 한국 소버린 AI 자동 유지보수 (Mac M5 Pro 24GB)
# ─────────────────────────────────────────────────────────────────────────────
#  하는 일:
#   1) 메모리 점검 → 일정 시간 idle 인 Ollama 모델 언로드
#   2) HuggingFace 다운로드 캐시 / 임시 파일 정리
#   3) Solar Pro GGUF 다운로드 끝났는데 Ollama 미등록 → 자동 등록
#   4) 디스크 사용량 / 모델 상태 리포트
#
#  Usage:
#    ./maintain.sh              # 대화형 (확인하며 진행)
#    ./maintain.sh --auto       # 무인 (cron 용, 메모리 정리만, HF 캐시 보존)
#    ./maintain.sh --deep       # 깊은 정리 (HF 캐시 포함, 확인 받음)
#    ./maintain.sh --status     # 점검만 (변경 없음)
# ─────────────────────────────────────────────────────────────────────────────
set -u
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

MODE="interactive"
for arg in "$@"; do
  case "$arg" in
    --auto)    MODE="auto" ;;
    --deep)    MODE="deep" ;;
    --status)  MODE="status" ;;
    -h|--help) sed -n '2,18p' "$0"; exit 0 ;;
  esac
done

HERE="$(cd "$(dirname "$0")" && pwd)"
MODELS="$HOME/models"
SOLAR_GGUF="$MODELS/solar-pro/solar-pro-preview-instruct.Q4_K_M.gguf"

log() { printf "[%(%F %T)T] %s\n" -1 "$*"; }
ok()   { log "✓ $*"; }
warn() { log "⚠ $*"; }

ask() {
  [[ "$MODE" != "interactive" && "$MODE" != "deep" ]] && return 0
  read -rp "  → 진행? [Y/n] " a
  [[ -z "$a" || "$a" =~ ^[Yy]$ ]]
}

# ─── 1) 메모리 점검 / Ollama 언로드 ──────────────────────────────────────────
log "─── 1) 메모리 / Ollama 모델 ───"
if command -v ollama >/dev/null && curl -s http://localhost:11434/api/tags >/dev/null 2>&1; then
  loaded=$(ollama ps 2>/dev/null | awk 'NR>1 {print $1}')
  if [[ -z "$loaded" ]]; then
    ok "로드된 모델 없음"
  else
    log "현재 로드: $(echo "$loaded" | paste -sd, -)"
    if [[ "$MODE" == "auto" ]] || ask; then
      while IFS= read -r m; do
        [[ -n "$m" ]] && ollama stop "$m" >/dev/null 2>&1 && ok "언로드: $m"
      done <<< "$loaded"
    fi
  fi
else
  warn "Ollama 미실행 (건너뜀)"
fi

# 떠있는 mlx 프로세스
mlx_pids=$(pgrep -f "mlx_lm" || true)
if [[ -n "$mlx_pids" ]]; then
  log "MLX 프로세스: $mlx_pids"
  if [[ "$MODE" == "auto" ]] || ask; then
    kill $mlx_pids 2>/dev/null && ok "MLX 종료"
  fi
fi

# ─── 2) Solar 자동 마무리 ────────────────────────────────────────────────────
log "─── 2) Solar Pro 등록 점검 ───"
if [[ -f "$SOLAR_GGUF" ]]; then
  if ollama list 2>/dev/null | awk '{print $1}' | grep -q "^solar-pro\(:.*\)\?$"; then
    ok "solar-pro 등록됨"
  else
    warn "GGUF 있는데 Ollama 미등록 → 자동 등록"
    if [[ "$MODE" == "auto" ]] || ask; then
      mf=$(mktemp -t solar-modelfile.XXXX)
      echo "FROM $SOLAR_GGUF" > "$mf"
      ollama create solar-pro -f "$mf" && ok "등록 완료"
      rm -f "$mf"
    fi
  fi
else
  ok "Solar GGUF 없음 (skip)"
fi

# ─── 3) 디스크 정리 ──────────────────────────────────────────────────────────
log "─── 3) 임시/락 파일 정리 ───"
tmp_files=$(find "$MODELS" -type f \( -name '*.incomplete' -o -name '*.lock' -o -name '*.tmp' \) 2>/dev/null)
if [[ -z "$tmp_files" ]]; then
  ok "임시 파일 없음"
else
  log "$(echo "$tmp_files" | wc -l | tr -d ' ') 개 발견"
  if [[ "$MODE" == "auto" ]] || ask; then
    echo "$tmp_files" | xargs rm -f && ok "삭제 완료"
  fi
fi

# HF 캐시 (deep 모드만)
if [[ "$MODE" == "deep" ]]; then
  log "─── 3-2) HuggingFace 캐시 (deep) ───"
  HF_CACHE="$HOME/.cache/huggingface"
  if [[ -d "$HF_CACHE" ]]; then
    sz=$(du -sh "$HF_CACHE" 2>/dev/null | awk '{print $1}')
    warn "HF 캐시: $sz  ($HF_CACHE)"
    warn "  ⚠ ~/models/ 의 변환된 모델은 안전 (캐시는 BF16 원본 백업용)"
    if ask; then
      rm -rf "$HF_CACHE" && ok "삭제 완료"
    fi
  fi
fi

# ─── 4) 리포트 ───────────────────────────────────────────────────────────────
log "─── 4) 상태 리포트 ───"
if [[ -d "$MODELS" ]]; then
  echo
  du -sh "$MODELS"/*/ 2>/dev/null | sed 's/^/  /'
fi
echo
if command -v ollama >/dev/null; then
  echo "  [Ollama 모델]"
  ollama list 2>/dev/null | sed 's/^/  /' | head -10
fi
echo
mem_used=$(vm_stat | awk '/Pages active/ {a=$3} /Pages wired/ {w=$4} END {print int((a+w)*4096/1024/1024/1024)}')
mem_total=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}')
log "메모리: ${mem_used}GB / ${mem_total}GB 사용 중"
ok "유지보수 완료"
