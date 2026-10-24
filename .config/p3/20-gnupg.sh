#!/usr/bin/env sh

# GNUPGHOME follows the data root, so on macOS it resolves under
# ~/Library/Application Support and on Linux under ~/.local/share. The conf
# files stay in $XDG_CONFIG_HOME on both, which is why gpg-agent and dirmngr
# have to be handed --options explicitly -- gnupg looks for them inside
# GNUPGHOME by default and would otherwise run on stock settings.
var "GNUPGHOME" "${XDG_DATA_HOME}/gnupg"
var "GNUPG_CONF" "${XDG_CONFIG_HOME}/gnupg/gpg.conf"
var "GNUPG_AGENT_CONF" "${XDG_CONFIG_HOME}/gnupg/gpg-agent.conf"
var "DIRMNGR_CONF" "${XDG_CONFIG_HOME}/dirmngr/dirmngr.conf"
