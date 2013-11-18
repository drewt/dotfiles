# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

EDITOR=vim
PATH=$PATH:/usr/local/cross/bin:/usr/games/bin

export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib/
export CMUS_HOME=$HOME/.config/cmus
