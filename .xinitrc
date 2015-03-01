#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset +fp /usr/share/fonts/terminus/

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# map caps lock to escape
(sleep 5s; xmodmap -e 'clear Lock' -e 'keycode 66 = Escape') &

# multiplexing for SLiM
case $1 in
xfce4)
	exec startxfce4
	;;
xmonad)
	#sh ~/.fehbg &
	xmobar &
	xsetroot -cursor_name left_ptr
	exec xmonad
	;;
dwm)
	nvidia-settings -l
	sh ~/.fehbg &
	exec dwm
	;;
awesome|*)
	nvidia-settings -l
	wicd-gtk --tray &
	exec awesome
	;;
esac
