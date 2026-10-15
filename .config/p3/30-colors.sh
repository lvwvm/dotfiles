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

# macOS has no GNU coreutils by default; use zerobrew's uutils-coreutils
# build (installed as uu-dircolors, not a plain `dircolors` symlink) instead.
# $P3_OS rather than a `has` probe, per 10-xdg.sh: this is a deliberate
# per-platform choice, not a fallback for a missing command.
if [ "$P3_OS" = "Darwin" ]; then
    _p3_dircolors="uu-dircolors"
else
    _p3_dircolors="dircolors"
fi

# uutils' dircolors (0.10.0) rejects some entries GNU accepts, e.g. bare
# filename rules like `Makefile 01;34` in trapd00r/LS_COLORS, and exits
# non-zero with nothing on stdout. Only eval on success and swallow stderr,
# so an incompatible db leaves LS_COLORS unset instead of erroring every
# login.
if has "${_p3_dircolors}" && [ -r "${LS_COLORS_CONFIG}" ]; then
    _p3_dircolors_out=$("${_p3_dircolors}" -b "${LS_COLORS_CONFIG}" 2>/dev/null) && eval "${_p3_dircolors_out}"
    unset _p3_dircolors_out
fi
unset _p3_dircolors
