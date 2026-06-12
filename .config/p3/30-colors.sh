#!/usr/bin/env sh

# LS_COLORS data is installed by bootstrap.sh, never at login.
# This module only exports environment.
var "LS_COLORS_HOME" "${XDG_DATA_HOME}/LS_COLORS"

# Generate $LS_COLORS from the trapd00r database (offline, ~ms).
# .zshrc completion list-colors depends on this being set.
if has "dircolors" && [ -r "${LS_COLORS_HOME}/LS_COLORS" ]; then
    eval "$(dircolors -b "${LS_COLORS_HOME}/LS_COLORS")"
fi
