#!/usr/bin/env sh

# Password store location
var "PASSAGE_DIR" "$XDG_DATA_HOME/pass"
[ ! -d "$PASSAGE_DIR" ] && mkdir "$PASSAGE_DIR"

# Identities file location
var "PASSAGE_IDENTITIES_FILE" "$PASSAGE_DIR/identities"

#  age binary (tested with age and rage)
var "PASSAGE_AGE" "$(command -v rage || command -v age || true)"

# PASSWORD_STORE_DIR - Overrides the default password storage directory.
var "PASSWORD_STORE_DIR" "$XDG_DATA_HOME/pass"
[ ! -d "$PASSWORD_STORE_DIR" ] && mkdir "$PASSWORD_STORE_DIR"

# PASSWORD_STORE_ENABLE_EXTENSIONS - This environment variable must be set to
# "true" for extensions to be enabled.
var "PASSWORD_STORE_ENABLE_EXTENSIONS" "true"

# PASSWORD_STORE_EXTENSIONS_DIR - The location to look for executable extension
# files, by default PASSWORD_STORE_DIR/.extensions.
var "PASSWORD_STORE_EXTENSIONS_DIR" "$PASSWORD_STORE_DIR/.ext"
[ ! -d "$PASSWORD_STORE_EXTENSIONS_DIR" ] && mkdir "$PASSWORD_STORE_EXTENSIONS_DIR"