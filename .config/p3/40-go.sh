#!/usr/bin/env sh

# Go comes from mise (see .config/mise/config.toml). The asdf bootstrap that
# used to live here was dead code: it only stayed dormant because has()
# returned true unconditionally. With has() fixed it would have started
# shelling out to asdf, which this config no longer uses.

config_golang() {
  # Go Environment Variables
  var "GOPATH" "${HOME}/.local"
  var "GOBIN" "${XDG_BIN_HOME}"
}

config_golang

unset config_golang
