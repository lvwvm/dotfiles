#!/usr/bin/env sh

# gpg-agent doubles as the ssh-agent. Two portability points:
#   - gpgconf is absent until gnupg is installed; without a guard this emits
#     "command not found" on every login.
#   - `awk -e` is a GNU extension. macOS awk warns "unknown option -e ignored"
#     and then treats the script as a filename, so pass it positionally.
# Leaving SSH_AUTH_SOCK unset is the correct fallback: macOS then uses its
# own launchd ssh-agent.
if has "gpgconf"; then
	_ssh_sock=$(gpgconf --list-dir | awk -F: '$1 == "agent-ssh-socket" { print $2 }')
	[ -n "$_ssh_sock" ] && var "SSH_AUTH_SOCK" "$_ssh_sock"
	unset _ssh_sock
fi

if [ -x "${XDG_BIN_HOME}/pinentry" ]; then
	var "SSH_ASKPASS" "${XDG_BIN_HOME}/pinentry"
fi
