#!/bin/sh

i3lock --blur=5 --force-clock --color=000000 --pass-media-keys \
    --greetercolor=928374ff \
    --timepos="ix-0:iy-400" --time-font=LatoLight --timesize=140 --timecolor=${THEME_FG}ff \
    --datepos="tx-0:ty+90" --date-font=LatoLight --datesize=42 --datecolor=${THEME_FG}ff \
    --insidecolor=00000000 --insidevercolor=00000000 --insidewrongcolor=00000000 --line-uses-inside \
    --ringcolor=${THEME_BLACK}ff --ringvercolor=${THEME_BLUE}ff --ringwrongcolor=${THEME_RED}ff \
    --keyhlcolor=${THEME_BLUE}ff --bshlcolor=${THEME_YELLOW}ff \
    --ring-width=4.0 --radius=75 \
    --verifcolor=${THEME_BLUE}ff --veriftext="..." \
    --wrongtext="Incorrect" --wrongcolor=${THEME_RED}ff \
    --noinputtext="Empty"
