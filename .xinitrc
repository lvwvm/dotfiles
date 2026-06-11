#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Same login environment as terminal shells (p3).
P3_DIR="${P3_DIR:-${HOME}/.config/p3}"
[ -z "${P3_LOADED}" ] && . "${HOME}/.profile" && P3_LOADED=1

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# awesome is kept as default
DEFAULT_SESSION=awesome

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# POSIX sh — no bash arrays here.
get_session() {
	case "${1:-$DEFAULT_SESSION}" in
		awesome) echo "awesome" ;;
		bspwm) echo "bspwm-session" ;;
		budgie) echo "budgie-desktop" ;;
		cinnamon) echo "cinnamon-session" ;;
		deepin) echo "startdde" ;;
		enlightenment) echo "enlightenment_start" ;;
		fluxbox) echo "startfluxbox" ;;
		gnome) echo "gnome-session" ;;
		i3|i3wm) echo "i3 --shmlog-size 0" ;;
		jwm) echo "jwm" ;;
		kde) echo "startkde" ;;
		lxde) echo "startlxde" ;;
		lxqt) echo "lxqt-session" ;;
		mate) echo "mate-session" ;;
		xfce) echo "xfce4-session" ;;
		openbox) echo "openbox-session" ;;
		*) echo "$DEFAULT_SESSION" ;;
	esac
}

xset r rate 500 33

exec dbus-launch --exit-with-session $(get_session "$1")
