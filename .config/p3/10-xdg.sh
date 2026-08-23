#!/usr/bin/env sh

# Each root honours a value already present in the environment and falls back
# to the default underneath $HOME. This lets a checkout be exercised from
# outside $HOME (e.g. a git worktree) by pre-setting XDG_CONFIG_HOME/P3_DIR
# before login. `var` always overwrites -- PATH construction below depends on
# that -- so the pass-through has to happen here, at the point of use.
#
# mkdir uses -p: on a fresh macOS ~/.local does not exist, so creating
# ~/.local/share with plain mkdir fails and noises up every login.
#
# macOS files the same categories under ~/Library, so on Darwin the two roots
# with a real counterpart there take it. $P3_OS rather than a `has` probe:
# framework layout is exactly what 05-os.sh reserves the variable for.
#
# The other roots stay put, for two different reasons. XDG_CONFIG_HOME cannot
# move by conditional alone -- this repo *is* $HOME and tracks its config tree
# at ~/.config, so moving the root without moving every tracked file with it
# would point every tool at an empty directory, and .profile finds p3 itself
# at ~/.config/p3 before any of this runs. bin, lib, include, build, var and
# templates simply have no ~/Library counterpart: it is not a place for
# executables, headers or build trees.
if [ "$P3_OS" = "Darwin" ]; then
    _p3_data_root="${HOME}/Library/Application Support"
    _p3_cache_root="${HOME}/Library/Caches"
else
    _p3_data_root="${HOME}/.local/share"
    _p3_cache_root="${HOME}/.cache"
fi

var "XDG_CONFIG_HOME" "${XDG_CONFIG_HOME:-${HOME}/.config}"
[ ! -d "${XDG_CONFIG_HOME}" ] && mkdir -p "${XDG_CONFIG_HOME}"

var "XDG_DATA_HOME" "${XDG_DATA_HOME:-${_p3_data_root}}"
[ ! -d "${XDG_DATA_HOME}" ] && mkdir -p "${XDG_DATA_HOME}"

var "XDG_BUILD_HOME" "${XDG_BUILD_HOME:-${HOME}/.local/build}"
[ ! -d "${XDG_BUILD_HOME}" ] && mkdir -p "${XDG_BUILD_HOME}"

var "XDG_BIN_HOME" "${XDG_BIN_HOME:-${HOME}/.local/bin}"
[ ! -d "${XDG_BIN_HOME}" ] && mkdir -p "${XDG_BIN_HOME}"

var "XDG_LIB_HOME" "${XDG_LIB_HOME:-${HOME}/.local/lib}"
[ ! -d "${XDG_LIB_HOME}" ] && mkdir -p "${XDG_LIB_HOME}"

var "XDG_INCLUDE_HOME" "${XDG_INCLUDE_HOME:-${HOME}/.local/include/}"
[ ! -d "${XDG_INCLUDE_HOME}" ] && mkdir -p "${XDG_INCLUDE_HOME}"

# add to path
var "PATH" "${XDG_BIN_HOME}:${PATH}"

# Project templates
var "XDG_TEMPLATE_HOME" "${XDG_TEMPLATE_HOME:-${HOME}/Templates}"
[ ! -d "${XDG_TEMPLATE_HOME}" ] && mkdir -p "${XDG_TEMPLATE_HOME}"

var "XDG_CACHE_HOME" "${XDG_CACHE_HOME:-${_p3_cache_root}}"
[ ! -d "${XDG_CACHE_HOME}" ] && mkdir -p "${XDG_CACHE_HOME}"

var "XDG_VAR_HOME" "${XDG_VAR_HOME:-${HOME}/.local/var}"
[ ! -d "${XDG_VAR_HOME}" ] && mkdir -p "${XDG_VAR_HOME}"

# set -a is in force, so these would otherwise leak into every process.
unset _p3_data_root _p3_cache_root

var "XDH" "${XDG_DATA_HOME}"
var "XBH" "${XDG_BIN_HOME}"
var "XCH" "${XDG_CONFIG_HOME}"
var "XCA" "${XDG_CACHE_HOME}"
