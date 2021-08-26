#!/bin/sh

i3lock --blur=5 --force-clock --color=000000 --pass-media-keys \
    --time-pos="ix-0:iy-400" --time-font=LatoLight --time-size=140 --time-color=${THEME_FG}ff \
    --date-pos="tx-0:ty+90" --date-font=LatoLight --date-size=42 --date-color=${THEME_FG}ff \
    --inside-color=00000000 --insidever-color=00000000 --insidewrong-color=00000000 --line-uses-inside \
    --ring-color=${THEME_BLACK}ff --ringver-color=${THEME_BLUE}ff --ringwrong-color=${THEME_RED}ff \
    --keyhl-color=${THEME_BLUE}ff --bshl-color=${THEME_YELLOW}ff \
    --ring-width=4.0 --radius=75 \
    --verif-color=${THEME_BLUE}ff --verif-text="..." \
    --wrong-text="Incorrect" --wrong-color=${THEME_RED}ff \
    --noinput-text="Empty"
