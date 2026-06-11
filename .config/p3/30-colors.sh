#!/usr/bin/env sh

# LS_COLORS data is installed by bootstrap.sh, never at login.
# This module only exports environment.
var "LS_COLORS_HOME" "${XDG_DATA_HOME}/LS_COLORS"
