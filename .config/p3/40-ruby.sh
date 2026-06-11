#!/usr/bin/env sh

var "GEM_HOME" "${XDG_DATA_HOME}/gem"
[ ! -d "${XDG_DATA_HOME}/gem" ] && mkdir "${XDG_DATA_HOME}/gem"

var "BUNDLE_USER_HOME" "${XDG_DATA_HOME}/bundle"
[ ! -d "${BUNDLE_USER_HOME}" ] && mkdir "${BUNDLE_USER_HOME}"

var "BUNDLE_USER_CONFIG" "${XDG_CONFIG_HOME}/bundleconf"
[ ! -f "${BUNDLE_USER_CONFIG}" ] && touch "${BUNDLE_USER_CONFIG}"

var "BUNDLE_USER_CACHE" "${XDG_CACHE_HOME}/bundle"
[ ! -d "${BUNDLE_USER_CACHE}" ] && mkdir "${BUNDLE_USER_CACHE}"

var "BUNDLE_USER_PLUGIN" "${BUNDLE_USER_HOME}/plugin"
[ ! -d "${BUNDLE_USER_PLUGIN}" ] && mkdir "${BUNDLE_USER_PLUGIN}"

var "RBENV_ROOT" "${XDG_DATA_HOME}/rbenv"
var "RBENV_PLUGINS" "${RBENV_ROOT}/plugins"

# rbenv and its plugins are installed by bootstrap.sh, never at login.

var "PATH" "${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}"