#!/bin/sh

grim -t png -g "$(slurp)" - | wl-copy
