#!/usr/bin/env sh

# virtualenvwrapper virtual environment location.
var "WORKON_HOME" "${XDG_DATA_HOME}/virtualenvs"
#var "PYENV_ROOT" "${XDG_DATA_HOME}/pyenv"
var "PIPX_HOME" "${XDG_DATA_HOME}/pipx"

# "where to place virtual environments."
if [ ! -d "${WORKON_HOME}" ]; then
  mkdir "${WORKON_HOME}"
fi

# pipx helps run python applications in isolated environments.
if [ ! -d "${PIPX_HOME}" ]; then
  mkdir "${PIPX_HOME}"
fi

# $pyenv_root stores location of managed python versions.
# pyenv is a simple modern python version manager.
# Bash must be installed in order to use it.
#if [ ! -d "${PYENV_ROOT}" ]; then
# curl https://pyenv.run | bash
#fi

# pyenv virtualenv support plugin.
#if [ ! -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
#  git clone https://github.com/pyenv/pyenv-virtualenv.git "${PYENV_ROOT}/plugins/pyenv-virtualenv"
#fi

# pyenv virtualenvwrapper support plugin.
#if [ ! -d "${PYENV_ROOT}/plugins/pyenv-virtualenvwrapper" ]; then
#  git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git "${PYENV_ROOT}/plugins/pyenv-virtualenvwrapper"
#fi

# all pyenv environments should be stored in the de-facto virtualenv directory
# we do this by linking the default pyenv versions directory to WORKON_HOME
#if [ ! -L "${PYENV_ROOT}/versions" ]; then
#  ln -s "${PYENV_ROOT}/versions" "${WORKON_HOME}"
#fi

# pyenv works by inserting a directory of shims at the front of your PATH
#var "PATH" "$PYENV_ROOT/shims:$PATH"

# any virtual environments created from the shell using mkvirtualenv will be created
# using pyvenv.
#var "PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV" "true"

# Poetry is a project dependency manager that also relies on
# virtual environments to create .
if has "poetry"; then
  var "POETRY_VIRTUALENVS_PATH" "${WORKON_HOME}"
fi

# user configuration location for pip
if [ ! -d "${XDG_CONFIG_HOME}/pip" ]; then
  mkdir "${XDG_CONFIG_HOME}/pip"
fi