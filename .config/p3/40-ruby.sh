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

# clone rbenv
if [ ! -d "${RBENV_ROOT}" ]; then
  git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT" &
fi

# create a plugins directory
[ ! -d "${RBENV_PLUGINS}" ] && mkdir "${RBENV_PLUGINS}"

# `rbenv install` plugin
if [ ! -d "${RBENV_PLUGINS}/rbenv-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git "${RBENV_PLUGINS}/ruby-build" &
fi

# rbenv path resolver plugin
if [ ! -d "${RBENV_PLUGINS}/rbenv-whatis" ]; then
  git clone https://github.com/rkh/rbenv-whatis "${RBENV_PLUGINS}/rbenv-whatis"
fi

# `rbenv use` plugin
if [ ! -d "${RBENV_PLUGINS}/rbenv-use" ]; then
  git clone https://github.com/rkh/rbenv-use "${RBENV_PLUGINS}/rbenv-use"
fi

# Bundler Integration for rbenv
if [ ! -d "${RBENV_PLUGINS}/rbenv-bundler" ]; then
  git clone https://github.com/carsomyr/rbenv-bundler "${RBENV_PLUGINS}/rbenv-bundler"
fi

# `rbenv default-gems` plugin
if [ ! -d "${RBENV_PLUGINS}/rbenv-default-gems" ]; then
  git clone https://github.com/rbenv/rbenv-default-gems "${RBENV_PLUGINS}/rbenv-default-gems"
fi

# share gems across rbenv versions
if [ ! -d "${RBENV_PLUGINS}/rbenv-communal-gems" ]; then
  git clone https://github.com/tpope/rbenv-communal-gems "${RBENV_PLUGINS}/rbenv-communal-gems"
fi

var "PATH" "${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}"