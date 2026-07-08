#!/usr/bin/env sh

# ZSH startup/shutdown files
var "ZDOTDIR" "${XDG_CONFIG_HOME}/zsh"

# sheldon (zsh plugin manager) reads config from $XDG_CONFIG_HOME/sheldon
# and clones/caches under $XDG_DATA_HOME/sheldon by default — no vars needed.

# The file to save the history in when an interactive shell exits.
var "HISTFILE" "${XDG_DATA_HOME}/zsh/histfile"

# The maximum number of events stored in the internal history list.
var "HISTSIZE" "12000"

# The maximum number of history events to save in the history file.
var "SAVEHIST" "10000"

# sheldon is installed by bootstrap.sh, never at login.
