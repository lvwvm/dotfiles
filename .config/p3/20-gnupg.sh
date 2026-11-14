#!/usr/bin/env sh

# GNUPGHOME follows the data root, so on macOS it resolves under
# ~/Library/Application Support and on Linux under ~/.local/share. The conf
# files stay in $XDG_CONFIG_HOME on both, which is why gpg-agent and dirmngr
# have to be handed --options explicitly -- gnupg looks for them inside
# GNUPGHOME by default and would otherwise run on stock settings.
#
# The exception is the agent conf on Darwin: the shared one carries Linux paths
# (scdaemon-program), so macOS uses its own, generated in GNUPGHOME where an
# agent gnupg auto-relaunches without --options reads it too.
var "GNUPGHOME" "${XDG_DATA_HOME}/gnupg"
var "GNUPG_CONF" "${XDG_CONFIG_HOME}/gnupg/gpg.conf"
if [ "$P3_OS" = "Darwin" ]; then
	var "GNUPG_AGENT_CONF" "${GNUPGHOME}/gpg-agent.conf"
else
	var "GNUPG_AGENT_CONF" "${XDG_CONFIG_HOME}/gnupg/gpg-agent.conf"
fi
var "DIRMNGR_CONF" "${XDG_CONFIG_HOME}/dirmngr/dirmngr.conf"
