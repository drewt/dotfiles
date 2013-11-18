#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset +fp /usr/share/fonts/terminus/

cmusstats(){
    if test "`pidof cmus`" != "" ; then
        TIME="`cmus-remote -Q | awk '/duration/ {print $2}'`"
        CURR="`cmus-remote -Q | awk '/position/ {print $2}'`"
        CURRF=`printf "%02d:%02d" $(($CURR/60)) $(($CURR%60))`
        TIMEF=`printf "%02d:%02d" $(($TIME/60)) $(($TIME%60))`
        ARTIST="`cmus-remote -Q | sed -ne '/artist/s/tag artist //pg'`"
        TITLE="`cmus-remote -Q | sed -ne '/title/s/tag title //pg'`"
        echo `printf "%s - %s [ %s / %s ] |" "$TITLE" "$ARTIST" "$CURRF" "$TIMEF"`
    fi
}

while true; do
    xsetroot -name "$(cmusstats) $(date +'%A %B %d, %R')"
    sleep 1s
done &

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
dwm|*)
	sh ~/.fehbg &
	exec dwm
	;;
esac
