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

# source zplug.
. "${ZPLUG_HOME}/init.zsh"

# check for updates.
if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async", from:"github"
zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:"github", as:"theme"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "chrissicool/zsh-256color"
zplug "chriskempson/base16-shell", from:"github", as:"plugin"
zplug "plugins/fasd", from:"oh-my-zsh"
zplug "plugins/fancy-ctrl-z", from:"oh-my-zsh"
zplug "plugins/colored-man-pages", from:"oh-my-zsh"
zplug "plugins/command-not-found", from:"oh-my-zsh"
zplug "plugins/vagrant", from:"oh-my-zsh"
zplug "plugins/docker", from:"oh-my-zsh"
zplug "plugins/terraform", from:"oh-my-zsh"
zplug "plugins/npm", from:"oh-my-zsh"
zplug "plugins/gem", from:"oh-my-zsh"
zplug "plugins/pip", from:"oh-my-zsh"
zplug "plugins/cargo", from:"oh-my-zsh"
zplug "plugins/git", from:"oh-my-zsh"
zplug "plugins/golang", from:"oh-my-zsh"
zplug "plugins/systemd", from:"oh-my-zsh"
zplug "MichaelAquilina/zsh-you-should-use", from:"github", as:"plugin"
zplug "robertaudi/tsm"
zplug "zsh-users/zsh-syntax-highlighting"

zplug load

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



alias -g ls='eza --group-directories-first'
alias -g ll='ls -l'
alias -g la='ll -a'
alias npm='pnpm'


eval "$(${XDG_BIN_HOME:-$HOME/.local/bin}/mise activate zsh)"