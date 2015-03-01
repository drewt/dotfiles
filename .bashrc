#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# colourful man pages
man ()
{
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}
export GROFF_NO_SGR=1

alias ls='ls --color=auto'
alias cgrep='grep -r -n --color -I'
alias make='make -j 6'
alias exit='history -c; exit'
alias snes9x='snes9x -paddev1 "/dev/input/js0"'
alias modefix='xrandr --output DVI-D-0 --mode 1920x1080 --output DVI-I-0 --mode 1600x900'

GREEN='\[\033[1;32m\]'
BLUE='\[\033[1;34m\]'
RESET='\[\033[00m\]'

PS1="$GREEN[\u@\h $BLUE\W$GREEN]\$ $RESET"

set -o vi
shopt -s checkwinsize

export SBCL_HOME='/usr/lib/sbcl'
export BROWSER='firefox'
