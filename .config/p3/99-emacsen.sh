#!/usr/bin/env sh

var "CENTAUR_DATA_HOME" "$EMACSEN_DATA_HOME/centaur"
var "CENTAUR_CONFIG_HOME" "$EMACSEN_CONFIG_HOME/centaur"

var "DOOMDIR" "${XDG_CONFIG_HOME}/emacsen/doom"
var "LOCALDOOMDIR" "${XDG_CACHE_HOME}/emacsen/doom"
var "DOOM_DATA_DIR" "${XDG_DATA_HOME}/emacsen/doom"

var "SPACEMACS_DATA_HOME" "$EMACSEN_DATA_HOME/spacemacs"
var "SPACEMACS_CONFIG_HOME" "$EMACSEN_CONFIG_HOME/spacemacs"

var "PRELUDE_DATA_HOME" "$EMACSEN_DATA_HOME/prelude"
var "PRELUDE_CONFIG_HOME" "$EMACSEN_CONFIG_HOME/prelude"

# Emacs distributions (centaur, doom, prelude, spacemacs) are installed by
# bootstrap.sh, never at login. This module only exports environment.