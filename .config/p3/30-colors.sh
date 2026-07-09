#!/usr/bin/env sh

# Normalized LS_COLORS using base16-compatible ANSI terminal color positions.
# Adapts automatically to any active base16 theme (phd, etc.) because
# base16-shell (loaded via sheldon) remaps terminal color slots 0-15.
#
# The canonical dircolors config lives under the sheldon ls-colors plugin at
#   ${XDG_CONFIG_HOME}/sheldon/plugins/ls-colors/dircolors
#
# This module duplicates the lookup so LS_COLORS is available even when
# sheldon hasn't been sourced (e.g. non-interactive login shells).

LS_COLORS_CONFIG="${XDG_CONFIG_HOME}/ls-colors/dircolors"
[ ! -r "${LS_COLORS_CONFIG}" ] && LS_COLORS_CONFIG="${XDG_CONFIG_HOME}/sheldon/plugins/ls-colors/dircolors"

if has "dircolors" && [ -r "${LS_COLORS_CONFIG}" ]; then
    eval "$(dircolors -b "${LS_COLORS_CONFIG}")"
fi
