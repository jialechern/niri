#!/usr/bin/env bash

# 可调项
BLUR="10x5"                 # 模糊强度，格式 radiusxtimes（越大越模糊）
VIGNETTE="0.45:0.45"       # vignette base:factor
DIM="0.40"                 # 覆盖暗度（0..1）
INDICATOR_RADIUS=270
INDICATOR_THICK=13
FONT="JetBrains Mono Nerd Font"  # 你机器上的字体名
FONT_SIZE=59
# nord 颜色（rrggbb）
COLOR_RING="81a1c1"
COLOR_INSIDE="2e3440"
COLOR_TEXT="d8dee9"
COLOR_KEY="88c0d0"
COLOR_WRONG="bf616a"

INSIDE_HEX="2e34405f"    # nord polar night + 半透明 (alpha=0x80)
RING_HEX="81a1c1ff"
TEXT_HEX="d8dee9ff"

# 首先尝试找到 swaylock-effects（有更多参数），否则回退到 swaylock
if command -v swaylock >/dev/null 2>&1; then
  SWAYLOCK_CMD="$(command -v swaylock)"
else
  echo "错误：找不到 swaylock，可通过包管理器安装 swaylock-effects 或 swaylock" >&2
  exit 1
fi

# 是否支持 effect 参数的简单检测（调用 --help 看有没有 --effect-blur）
if "$SWAYLOCK_CMD" --help 2>&1 | grep -q -- '--effect-blur'; then
  # 使用 swaylock-effects 的参数
  "$SWAYLOCK_CMD" -f \
    --screenshots \
    --clock \
    --timestr "%H:%M" \
    --datestr "%Y年 %b %d日" \
    --effect-blur "${BLUR}" \
    --effect-vignette "${VIGNETTE}" \
    --indicator \
    --indicator-radius "${INDICATOR_RADIUS}" \
    --indicator-thickness "${INDICATOR_THICK}" \
    --font "${FONT}:size=${FONT_SIZE}" \
    --font-size "${FONT_SIZE}" \
    --ring-color "${RING_HEX}" \
    --inside-color "${INSIDE_HEX}" \
    --text-color "${TEXT_HEX}" \
    --key-hl-color "${COLOR_KEY}" \
    --ring-wrong-color "${COLOR_WRONG}" \
    --line-uses-ring
else
  # 回退到基本 swaylock 参数（没有特效）
  "$SWAYLOCK_CMD" -f \
    --clock \
    --indicator \
    --font "${FONT}:size=${FONT_SIZE}" \
    --font-size "${FONT_SIZE}" \
    --color 2e3440ff \
    --inside-color 2e3440ff \
    --ring-color 81a1c1ff \
    --text-color d8dee9ff \
    --key-hl-color 88c0d0ff \
    --ring-wrong-color bf616aff
fi
