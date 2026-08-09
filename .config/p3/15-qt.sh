#!/usr/bin/env sh

# X11-specific Qt tuning. macOS Qt uses the Cocoa platform plugin, where
# qt5ct is not a valid platform theme.
[ "$P3_OS" = "Linux" ] || return 0

var "QT_AUTO_SCREEN_SCALE_FACTOR" 0
var "QT_QPA_PLATFORMTHEME" "qt5ct"
