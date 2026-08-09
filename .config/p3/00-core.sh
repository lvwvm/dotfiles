#!/usr/bin/env sh

var "PATH" "$PATH"
var "LC_ALL" "en_US.UTF-8"
var "LANG" "en_US.UTF-8"
var "TZ" "America/Chicago"
var "TERM" "xterm-256color"

# macOS hands each user a private per-boot TMPDIR under /var/folders and
# expects it to be honoured; only Linux needs /tmp spelled out.
if [ "$P3_OS" = "Linux" ]; then
    var "TMPDIR" "/tmp"
fi

# Resolve by lookup rather than absolute path: Homebrew, zerobrew, mise and
# /usr/bin place these differently across the two platforms.
if has "less"; then
    var "PAGER" "$(command -v less) -RF"
fi

if has "emacsclient"; then
    var "EDITOR" "$(command -v emacsclient) -c --socket-name doom"
elif has "nvim"; then
    var "EDITOR" "$(command -v nvim)"
elif has "vi"; then
    var "EDITOR" "$(command -v vi)"
fi
