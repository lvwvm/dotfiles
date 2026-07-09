# Normalized LS_COLORS using base16-compatible ANSI terminal color positions.
# Adapts automatically to any active base16 theme (phd, default-dark, etc.)
# because base16-shell remaps terminal color slots 0-15.

local config="${XDG_CONFIG_HOME:-$HOME/.config}/ls-colors/dircolors"
local self="${${(%):-%x}:a:h}/dircolors"

if ! [ -r "$config" ] && [ -r "$self" ]; then
  config="$self"
fi

if (( $+commands[dircolors] )) && [ -r "$config" ]; then
  eval "$(dircolors -b "$config")"
fi
