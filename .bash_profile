#!/usr/bin/env bash
# Thin shim — canonical init: ~/.config/p3/p3.sh (sources $P3_DIR/*.sh)
P3_DIR="${P3_DIR:-${HOME}/.config/p3}"
. "${P3_DIR}/p3.sh"

# Interactive bash settings live in ~/.bashrc
[[ $- == *i* ]] && [[ -f ~/.bashrc ]] && . ~/.bashrc
