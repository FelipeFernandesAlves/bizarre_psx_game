#!/bin/sh
printf '\033c\033]0;%s\a' Midnight Dancer
base_path="$(dirname "$(realpath "$0")")"
"$base_path/MidnightDancer.x86_64" "$@"
