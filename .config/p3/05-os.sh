#!/usr/bin/env sh

# Coarse OS discriminator: "Darwin" or "Linux".
#
# Numbered 05 so it lands before 10-xdg.sh and is readable by every module
# downstream.
#
# Prefer `has "tool"` over branching on $P3_OS. Most Linux/macOS divergence
# here is really "is this tool installed", and the modules are already written
# that way -- this variable is for the genuine platform differences that tool
# presence cannot answer (framework layout, package-manager conventions).

var "P3_OS" "$(uname -s)"
