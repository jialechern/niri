#!/usr/bin/env bash

# 十五分钟自动锁屏、半小时熄屏、永不休眠
swayidle -w \
    timeout 900     '~/.config/niri/scripts/swaylock.sh' \
    timeout 1800    'niri msg action power-off-monitors' \
    resume          'niri msg action power-on-monitors'

