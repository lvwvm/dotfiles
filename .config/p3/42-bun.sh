#!/usr/bin/env sh

if has "bun"; then
  if [ ! -d "${XDG_LIB_HOME}/bun" ]; then
    mkdir "${XDG_LIB_HOME}/bun"
  fi
  var "BUN_INSTALL_CACHE_DIR" "${XDG_CACHE_HOME}/bun"
  var "BUN_INSTALL_GLOBAL_DIR" "${XDG_LIB_HOME}/bun"
  var "BUN_INSTALL_BIN" "${XDG_BIN_HOME}"
else
  echo "Bun is not installed."
  echo "Installing Bun."
fi