#!/usr/bin/env sh

# ZSH startup/shutdown files
var "ZDOTDIR" "${XDG_CONFIG_HOME}/zsh"

# Location of ZPLUG_HOME
var "ZPLUG_HOME" "${XDG_DATA_HOME}/zplug"

# All binaries go here.
var "ZPLUG_BIN" "${XDG_BIN_HOME}"

# Location of downloaded zplug repos
var "ZPLUG_REPOS" "${ZPLUG_HOME}/repos"

# Location of zplug cache.
var "ZPLUG_CACHE_DIR" "${XDG_CACHE_HOME}/zplug"

# The file to save the history in when an interactive shell exits.
var "HISTFILE" "${XDG_DATA_HOME}/zsh/histfile"

# The maximum number of events stored in the internal history list.
var "HISTSIZE" "12000"

# The maximum number of history events to save in the history file.
var "SAVEHIST" "10000"

# zplug is installed by bootstrap.sh, never at login.
