#!/usr/bin/env sh

# EMACSDIR - a default "emacs.d" data location.
var "EMACSDIR" "${XDG_DATA_HOME}/emacsen/doom"

# EMACSEN_CONFIG_HOME - path to various `distribution\profile` configurations.
var "EMACSEN_CONFIG_HOME" "${XDG_CONFIG_HOME}/emacsen"

# EMACSEN_DATA_HOME - the path to various `distributions`.
var "EMACSEN_DATA_HOME" "${XDG_DATA_HOME}/emacsen"

# This script was created, primarily, to handle the chemacs2 emacs profile manager.
# Chemacs2 MUST exist at ~/.emacs.d
# if [ ! -d "$XDG_DATA_HOME/chemacs2" ]; then
#  git clone https://github.com/plexus/chemacs2.git "$XDG_DATA_HOME/chemacs2"
# fi

# The "emacsen" folder is storing emacs.d "distributions" like spacemacs, doom, prelude etc.
[ ! -d "$EMACSEN_DATA_HOME" ] && mkdir "$EMACSEN_DATA_HOME"
[ ! -d "$EMACSEN_CONFIG_HOME" ] && mkdir "$EMACSEN_CONFIG_HOME"

# Emacs init search file order ~/.emacs.el, ~/.emacs, ~/.emacs.d/init.el - but remeber chemacs must see ~/.emacs.d
# These path are prefered by emacs for backwards compatibility.
# Setting XDG_CONFIG_HOME alters emacs' search behavior, although the aforementioned files must be deleted, renamed, and/or unlinked in order to do so.
# for _file in ~/.emacs.d/init.el ~/.emacs.el ~/.emacs; do
#  case $_file in
#    ~/.emacs.d/init.el)
#      _path=$(dirname $_file)
#
#      # no existing ~/.emacs.d or link.
#      if [ ! -d "$_path" ] && [ ! -h "$_path" ]; then
#        ln -sT "$_path" "$XDG_DATA_HOME/chemacs2"
#
#      # existing ~/.emacs.d, no link
#      elif [ -d "$_path" ] && [ ! -h "$_path" ]; then
#        # move emacs.d contents to emacsen folder.
#       mv --no-clobber \
#         --backup=simple \
#         --suffix=.bk \
#         "$_path" "$EMACSEN_DATA_HOME"
#       ln -sT "$_path" "$XDG_DATA_HOME/chemacs2"
#     fi
#     ;;

#   ~/.emacs.el | ~/.emacs)
#     # no exist emacs init file or link
#     if [ -f "$_file" ] && [ ! -h "$_file" ]; then
#       mv --backup=simple \
#         --suffix=.bk \
#         "$_file" "$EMACSEN_DATA_HOME/emacs.d/"
#     elif [ -f "$_file" ] && [ -h "$_file" ]; then
#       unlink "$_file"
#     fi
#     ;;
# esac
# unset _file
# unset _path
# done