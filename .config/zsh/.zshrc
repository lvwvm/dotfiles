#!/usr/bin/env zsh

# Auto correct mistakes
setopt correct

# appendhistory - If this is set, zsh sessions will append their history list to the history file, rather than replace it.
setopt appendhistory

# autocd - If a command is issued that can't be executed as  a  normal command,  and  the command is the name of a directory, perform the cd command to that directory.
setopt autocd

# beep - Beep on error in ZLE.
setopt beep

# extendedglob - Treat the `#', `~' and `^' characters as part  of  patterns for  filename  generation,  etc.
setopt extendedglob

# nomatch - If a pattern for filename generation has no matches,  print an  error,  instead of leaving it unchanged in the argument list.
setopt nomatch

# notify - Report  the  status  of background jobs immediately, rather than waiting until just before printing a prompt.
setopt notify

setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_fcntl_lock
setopt hist_no_store
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt inc_append_history

# bindkey manages keymaps and bindings.
# '-e' selects the emacs keymap as the main keymap
bindkey -e

GPG_TTY=$(tty)
SSH_TTY=$(tty)

export SSH_TTY
export GPG_TTY

# Several oh-my-zsh plugins (fasd, docker, gem, npm) cache generated
# completions under $ZSH_CACHE_DIR. oh-my-zsh core normally sets this; since
# sheldon only clones the individual plugin dirs, set it ourselves using
# oh-my-zsh's own upstream default fallback.
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/oh-my-zsh"
mkdir -p "${ZSH_CACHE_DIR}/completions"
fpath=("${ZSH_CACHE_DIR}/completions" $fpath)

# completion settings

zstyle ':completion:*' add-space true
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*' completer _list _oldlist _expand _complete _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 0
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e Possible Errors'
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename "${ZDOTDIR}/.zshrc"




autoload -Uz compinit
compinit

# End of lines added by compinstall

# source sheldon-managed plugins (see ${XDG_CONFIG_HOME}/sheldon/plugins.toml).
eval "$(sheldon source)"



alias -g ls='eza --group-directories-first'
alias -g ll='ls -l'
alias -g la='ll -a'
alias npm='pnpm'


eval "$(${XDG_BIN_HOME:-$HOME/.local/bin}/mise activate zsh)"