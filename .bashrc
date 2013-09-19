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
alias cgrep='grep -r -n --color'
alias make='make -j 6'
alias exit='history -c; exit'

PS1='\[\e[1;32m\][\u@\h\[\e[1;34m\] \W\[\e[1;32m\]]\$\[\e[m\] '
EDITOR=vim
PATH=$PATH:/usr/local/cross/bin:/usr/games/bin
export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib/
