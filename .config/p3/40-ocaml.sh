#!/usr/bin/env sh

var "OPAMROOT" "${XDG_DATA_HOME}/opam"

# Quoted: on macOS this resolves under "Application Support", and an
# unquoted expansion word-splits on the space into two failed mkdirs.
if [ ! -d "$OPAMROOT" ]; then
	mkdir "$OPAMROOT"
fi
