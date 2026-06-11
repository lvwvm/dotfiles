#!/usr/bin/env zsh
# Sourced by every zsh via the ~/.zshenv symlink -> $ZDOTDIR/.zshenv.
# Must set ZDOTDIR here, before zsh looks for .zprofile/.zshrc.
# Login environment comes from p3 via $ZDOTDIR/.zprofile -> ~/.profile.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
