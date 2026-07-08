#!/usr/bin/env sh
# p3 bootstrap — one-time provisioning after a fresh install.
# Run explicitly: sh ~/.config/p3/bootstrap.sh
# NEVER sourced at login. Login modules (*.sh) only export environment;
# everything that touches the network or installs software lives here.

set -e

P3_DIR="${P3_DIR:-${HOME}/.config/p3}"
. "${P3_DIR}/p3.sh"

say() { printf '==> %s\n' "$1"; }

clone() { # clone <url> <dest> [extra git args...]
    url="$1"; dest="$2"; shift 2
    if [ -d "$dest" ]; then
        say "skip $dest (exists)"
    else
        say "clone $url -> $dest"
        git clone "$@" "$url" "$dest"
    fi
}

# --- zsh: sheldon ------------------------------------------------------------
if ! command -v sheldon >/dev/null 2>&1; then
    say "install sheldon"
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to "${XDG_BIN_HOME}"
fi

# --- ls colors --------------------------------------------------------------
# Login (30-colors.sh) evals dircolors against the repo's LS_COLORS db.
# NB: removed the old `ln -sf ~/.dir_colors ...` — inverted and destructive:
# it replaced the database with a symlink to nonexistent ~/.dir_colors.
clone https://github.com/trapd00r/LS_COLORS "${XDG_DATA_HOME}/LS_COLORS"

# --- ruby: rbenv + plugins ---------------------------------------------------
clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
mkdir -p "${RBENV_PLUGINS}"
clone https://github.com/rbenv/ruby-build.git        "${RBENV_PLUGINS}/ruby-build"
clone https://github.com/rkh/rbenv-whatis            "${RBENV_PLUGINS}/rbenv-whatis"
clone https://github.com/rkh/rbenv-use               "${RBENV_PLUGINS}/rbenv-use"
clone https://github.com/carsomyr/rbenv-bundler      "${RBENV_PLUGINS}/rbenv-bundler"
clone https://github.com/rbenv/rbenv-default-gems    "${RBENV_PLUGINS}/rbenv-default-gems"
clone https://github.com/tpope/rbenv-communal-gems   "${RBENV_PLUGINS}/rbenv-communal-gems"

# --- mise --------------------------------------------------------------------
if ! command -v mise >/dev/null 2>&1; then
    say "install mise"
    curl -fsSL https://mise.run | sh
fi

# --- emacs distributions ------------------------------------------------------
clone https://github.com/seagle0128/.emacs.git "${CENTAUR_DATA_HOME}" --depth 1
clone https://github.com/hlissner/doom-emacs   "${DOOM_DATA_DIR}"
clone https://github.com/syl20bnr/spacemacs    "${SPACEMACS_DATA_HOME}"

if [ ! -h "${XDG_BIN_HOME}/doom" ] && [ -x "${DOOM_DATA_DIR}/bin/doom" ]; then
    ln -sT "${DOOM_DATA_DIR}/bin/doom" "${XDG_BIN_HOME}/doom"
fi
if command -v doom >/dev/null 2>&1; then
    doom env -a 'SSH_AUTH_SOCK|DBUS_SESSION_BUS_ADDRESS' >/dev/null 2>&1 || true
fi

# prelude (curl|sh installer — review before enabling)
# PRELUDE_INSTALL_DIR="${PRELUDE_DATA_HOME}" \
#     curl -fsSL https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh

# --- systemd user units -------------------------------------------------------
# Enable-state (.wants/ symlinks) is machine-local and NOT in git; without
# this a fresh install has units but nothing enabled (no gpg-agent socket
# => SSH_AUTH_SOCK dead). Portable set only — machine-specific units
# (asusd-user, asus-notify, appimagelauncherd, docker-desktop, geoclue,
# claude-cowork, podman) are enabled by hand where applicable.
if command -v systemctl >/dev/null 2>&1; then
    for u in dbus-broker.service \
             gpg-agent.socket gpg-agent-ssh.socket gpg-agent-extra.socket \
             gpg-agent-browser.socket dirmngr.socket pcscd.socket \
             pipewire.socket pipewire-pulse.socket wireplumber.service \
             picom.service redshift-gtk.service emacs-doom.service \
             xdg-user-dirs.service; do
        systemctl --user enable "$u" >/dev/null 2>&1 || say "skip enable $u (unit missing)"
    done
fi

say "bootstrap complete"
