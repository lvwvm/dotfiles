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

install_centaur() {
  git clone --depth 1 https://github.com/seagle0128/.emacs.git "$CENTAUR_DATA_HOME"
}

install_prelude() {
  PRELUDE_INSTALL_DIR="$PRELUDE_DATA_HOME"
  PRELUDE_URL="https://github.com/bbatsov/prelude"
  curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
}

install_spacemacs() {
  git clone https://github.com/syl20bnr/spacemacs "$SPACEMACS_DATA_HOME"
}

if [ ! -d "$CENTAUR_DATA_HOME" ]; then
  install_centaur
fi

# DOOM's data directory
if [ ! -d "${DOOM_DATA_DIR}" ]; then
  git clone https://github.com/hlissner/doom-emacs "${DOOM_DATA_DIR}"
fi

if [ ! -h "${XDG_BIN_HOME}/doom" ]; then
  ln -sT "${DOOM_DATA_DIR}/bin/doom" "${XDG_BIN_HOME}"
fi

if has "doom"; then
  doom env -a "SSH_AUTH_SOCK\|DBUS_SESSION_BUS_ADDRESS" 1>&/dev/null
fi

if [ ! -d "$PRELUDE_DATA_HOME" ]; then
  install_prelude
fi

if [ ! -d "$SPACEMACS_DATA_HOME" ]; then
  install_spacemacs
fi

unset install_centaur
unset install_prelude
unset PRELUDE_INSTALL_DIR
unset install_spacemacs