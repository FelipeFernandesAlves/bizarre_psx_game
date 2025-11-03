#!/bin/sh
printf '\033c\033]0;%s\a' bizarro
base_path="$(dirname "$(realpath "$0")")"
"$base_path/bizarro.x86_64" "$@"
