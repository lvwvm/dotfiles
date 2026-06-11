#!/usr/bin/env sh

# Path to a direnv files load strictly for the user."
var "USER_DIRENV_DATA" "${XDG_DATA_HOME}/direnv/"

if [ ! -d "${USER_DIRENV_DATA}" ]; then
  mkdir "${USER_DIRENV_DATA}"
fi