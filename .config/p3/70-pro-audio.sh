#!/usr/bin/env sh

# LADSPA/LV2 live under /usr/lib on Linux. macOS hosts use AU/VST out of
# /Library/Audio/Plug-Ins instead, so these paths have no meaning there.
[ "$P3_OS" = "Linux" ] || return 0

var "LADSPA_PATH" "/usr/lib/ladspa/"
var "LV2_PATH" "/usr/lib/lv2/"
