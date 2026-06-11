#!/usr/bin/env sh

# Considering using this to pass variables to environment
miseenv() {
    k="$1"
    v="$2"
    if [ "$#" -ge 2 ]; then
        mise set "$k" "$v"
    elif [ "$#" -eq 1 ]; then
        mise set "$k"
    fi
}

if ! has "mise"; then
    curl https://mise.run/zsh | sh
fi