#!/usr/bin/env bash
# 🇰🇷 한국 소버린 AI 런처 — M5 Pro 24GB
# Usage: ./sovereign_ai_launcher.sh [exaone|exaone-mlx|ax|solar|menu]
#
# 동작:
#   - 메뉴에서 모델 선택 → 대화형 채팅
#   - 채팅 종료(Ctrl+D / /bye) 후 메모리에서 완전 언로드
#   - 메뉴로 돌아가 다른 모델 선택 가능 (이전 모델은 이미 내려진 상태)

set -u
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

EXAONE_OLLAMA="hf.co/LGAI-EXAONE/EXAONE-4.0-1.2B-GGUF:Q4_K_M"
EXAONE_MLX="$HOME/models/exaone-4.0-1.2b-4bit-mlx"
AX_MLX="$HOME/models/ax-4.0-light-4bit-mlx"
SOLAR_OLLAMA="solar-pro"

# ─── 메모리 정리 ──────────────────────────────────────────────────────────────
unload_all_ollama() {
  # 현재 로드된 모든 ollama 모델을 메모리에서 즉시 내림
  local loaded
  loaded=$(ollama ps 2>/dev/null | awk 'NR>1 {print $1}')
  if [[ -n "$loaded" ]]; then
    echo "🧹 Ollama 메모리 정리: $loaded"
    while IFS= read -r m; do
      [[ -n "$m" ]] && ollama stop "$m" >/dev/null 2>&1 || true
    done <<< "$loaded"
  fi
}

cleanup() {
  unload_all_ollama
  # MLX는 프로세스 종료 시 메모리 자동 반환 (별도 작업 불필요)
}
trap cleanup EXIT INT TERM

# ─── 실행기 ───────────────────────────────────────────────────────────────────
run_exaone_ollama() {
  unload_all_ollama
  echo "▶ EXAONE 4.0 1.2B (Ollama / GGUF Q4_K_M) — ~0.8GB"
  echo "  종료: /bye  |  새 줄: Shift+Enter"
  ollama run "$EXAONE_OLLAMA" || true
  ollama stop "$EXAONE_OLLAMA" >/dev/null 2>&1 || true
  echo "✓ EXAONE(Ollama) 메모리에서 내림"
}

run_exaone_mlx() {
  unload_all_ollama
  echo "▶ EXAONE 4.0 1.2B (MLX 4bit) — ~0.7GB, 가장 빠름"
  echo "  종료: Ctrl+D"
  python3 -m mlx_lm chat --model "$EXAONE_MLX" --max-tokens 1024 || true
  echo "✓ EXAONE(MLX) 프로세스 종료 → 메모리 반환"
}

run_ax_mlx() {
  unload_all_ollama
  if [[ ! -f "$AX_MLX/config.json" ]]; then
    echo "❌ A.X MLX 모델 없음: $AX_MLX" >&2
    return 1
  fi
  echo "▶ SKT A.X 4.0 Light (MLX 4bit) — ~4.5GB, 한국어 최강"
  echo "  종료: Ctrl+D"
  python3 -m mlx_lm chat --model "$AX_MLX" --max-tokens 1024 || true
  echo "✓ A.X(MLX) 프로세스 종료 → 메모리 반환"
}

run_solar() {
  unload_all_ollama
  echo "▶ Solar Pro 22B (Upstage) — ~13GB, 메모리 빡빡"
  echo "  종료: /bye"
  ollama run "$SOLAR_OLLAMA" || true
  ollama stop "$SOLAR_OLLAMA" >/dev/null 2>&1 || true
  echo "✓ Solar 메모리에서 내림"
}

# ─── 도움말 ───────────────────────────────────────────────────────────────────
show_help() {
  cat <<'EOF'

══════════════════════════════════════════════════════════════════════
 🇰🇷 Korean Sovereign AI Launcher — 도움말
══════════════════════════════════════════════════════════════════════

▌ 명령어 (메뉴 입력 / CLI 인자 모두 동일)

   /exaone     | exaone        EXAONE 1.2B (Ollama)
   /exaone-mlx | exaone-mlx    EXAONE 1.2B (MLX, 가장 빠름)
   /ax         | ax            A.X 4.0 Light (MLX, 한국어 강세)
   /solar      | solar         Solar Pro 22B (Ollama)
   /unload     | unload        모든 Ollama 모델 메모리 강제 정리
   /ps                         현재 로드된 Ollama 모델 표시
   /help       | help, -h      이 도움말
   /quit       | quit          종료

   숫자 단축(메뉴 안에서만): 1=exaone 2=exaone-mlx 3=ax 4=solar

▌ CLI 예
   ./sovereign_ai_launcher.sh           # 메뉴 진입
   ./sovereign_ai_launcher.sh ax        # 바로 A.X 채팅
   ./sovereign_ai_launcher.sh /unload   # 슬래시도 인자로 허용

▌ 채팅 종료
   - Ollama (/exaone, /solar)  : /bye
   - MLX    (/exaone-mlx, /ax) : Ctrl+D

══════════════════════════════════════════════════════════════════════
▌ 모델 소개 — 한국 소버린 AI 라인업
══════════════════════════════════════════════════════════════════════

【 EXAONE 4.0 1.2B 】  LG AI Research
  • 풀네임   : EXpert Ai for EveryONE 4.0
  • 개발사   : LG AI연구원 (한국, 2020 설립)
  • 라이선스 : EXAONE AI Model License (연구용 무료, 상업은 별도)
  • 학습     : LG 자체 슈퍼컴 + 한국어/영어/코드 멀티링구얼
  • 특징
     - LG 그룹 전사 AI 전략의 핵심 (가전·화학·통신 도메인 튜닝)
     - 4.0 세대는 1.2B / 7.8B / 32B 라인업, 작은데 한국어 품질 좋음
     - "독자 AI 파운데이션 모델(독파모)" 정부 사업 후보 모델
  • 메모리   : Ollama Q4_K_M ~0.8GB / MLX 4bit ~0.7GB
  • 속도     : MLX 4bit가 압도적 (M5 Pro에서 ~280 tok/s 측정)

【 SKT A.X 4.0 Light 】  SK텔레콤 AI 모델 연구소
  • 풀네임   : Adaptive eXperience 4.0 (Light 변종)
  • 학습 인프라: SKT 자체 슈퍼컴 "TITAN" (NVIDIA H100 1,000+ GPU)
  • 라이선스 : Apache 2.0 (한국 소버린 모델 중 가장 개방적, 상업 가능)
  • 컨텍스트 : 32K (네이티브) / 131K (YaRN 확장)
  • 특징
     - 한국어 토크나이저 자체 개발 → GPT-4o 대비 한국어 토큰 33% 절약
       (= 같은 비용으로 더 긴 한국어 처리 + 응답 빠름)
     - KMMLU 69.2점 (한국어 종합 벤치, 동급 최상위권)
     - SKT 통신·고객 서비스 데이터로 도메인 튜닝 → 실생활 한국어 강세
     - "독파모" 사업 핵심 후보
  • 메모리   : MLX 4bit ~4.5GB (원본 BF16 14GB)

【 Solar Pro Preview 22B 】  Upstage (업스테이지)
  • 라이선스 : MIT (가장 개방적)
  • 파라미터 : 22B dense — "Depth Up-Scaling(DUS)" 기법으로 효율적 확장
  • 특징
     - 70B 급 reasoning 성능을 22B 로 달성 (Upstage 자체 벤치)
     - 한국 스타트업이 만든 글로벌 경쟁력 모델
     - 영어/한국어 모두 우수, 코드/수학 균형
     - "Preview" — 정식 Solar Pro(109B) 의 사전 공개 버전
  • 메모리   : Ollama Q4_K_M ~13GB
  • ⚠ 24GB RAM 환경: 다른 무거운 앱 닫고 실행 권장

▌ 한국 소버린 AI = 데이터 주권 + 자체 모델 + 자체 인프라
   정부 "독자 AI 파운데이션 모델(독파모)" 사업 후보:
   - LG AI연구원 (EXAONE)
   - SK텔레콤 (A.X)
   - 네이버 (HyperCLOVA X) — 외부 미공개
   - Upstage (Solar) — 글로벌 노선
   - NCSOFT, KT, 카카오 등

▌ 동작 보장
   - 모델 변경 시 이전 모델 자동 메모리 언로드
   - 채팅 종료 시 ollama stop 자동 호출
   - 비상 종료(Ctrl+C)에도 trap 으로 정리
══════════════════════════════════════════════════════════════════════
EOF
}

show_ps() {
  echo
  ollama ps 2>/dev/null || echo "(ollama 미실행)"
}

# ─── 메뉴 (루프) ──────────────────────────────────────────────────────────────
menu() {
  while true; do
    echo
    echo "==============================="
    echo " 🇰🇷 Korean Sovereign AI Launcher"
    echo "==============================="
    # 현재 메모리 상태
    local cur
    cur=$(ollama ps 2>/dev/null | awk 'NR>1 {print $1}' | paste -sd, -)
    if [[ -n "$cur" ]]; then
      echo " (현재 Ollama 로드됨: $cur)"
    else
      echo " (메모리 깨끗함)"
    fi
    echo " /exaone      EXAONE 1.2B (Ollama)        ~0.8GB"
    echo " /exaone-mlx  EXAONE 1.2B (MLX 4bit)      ~0.7GB ★ 가장 빠름"
    echo " /ax          SKT A.X 4.0 Light (MLX)     ~4.5GB ★ 한국어 강세"
    echo " /solar       Solar Pro 22B (Ollama)      ~13GB"
    echo " /unload      메모리 강제 정리"
    echo " /ps          현재 로드 모델 보기"
    echo " /help        도움말"
    echo " /quit        종료"
    echo "-------------------------------"
    read -rp "> " choice
    # 앞의 / 와 공백 제거, 소문자화
    choice="${choice#/}"
    choice="${choice// /}"
    choice=$(printf '%s' "$choice" | tr '[:upper:]' '[:lower:]')
    case "$choice" in
      1|exaone)              run_exaone_ollama ;;
      2|exaone-mlx|exaonemlx) run_exaone_mlx ;;
      3|ax)                  run_ax_mlx ;;
      4|solar)               run_solar ;;
      u|unload)              unload_all_ollama; echo "✓ 정리 완료" ;;
      ps|status)             show_ps ;;
      h|help|"?")            show_help ;;
      q|quit|exit|bye)       exit 0 ;;
      "")                    : ;;  # 그냥 엔터 → 무시
      *) echo "잘못된 명령: '$choice'  (/help 입력)" ;;
    esac
  done
}

# CLI 인자도 슬래시 허용
arg="${1:-menu}"
arg="${arg#/}"

case "$arg" in
  exaone)         run_exaone_ollama ;;
  exaone-mlx)     run_exaone_mlx ;;
  ax)             run_ax_mlx ;;
  solar)          run_solar ;;
  unload)         unload_all_ollama ;;
  ps|status)      show_ps ;;
  help|-h|--help) show_help ;;
  quit|exit)      exit 0 ;;
  menu|"")        menu ;;
  *) echo "Usage: $0 [/exaone|/exaone-mlx|/ax|/solar|/unload|/ps|/help|menu]"; exit 1 ;;
esac
