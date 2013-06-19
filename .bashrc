#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

open-crypt ()
{
    echo 'Opening...'
    sudo cryptsetup luksOpen UUID=294708d6-b8aa-4f2d-80a7-1dde5adb980a crypt \
        --key-file /etc/keys/sg-key || return 1
    echo 'Mounting...'
    sudo mount /dev/mapper/crypt /media/crypt
}

close-crypt ()
{
    sudo umount /media/crypt || return 1
    sudo cryptsetup luksClose crypt
}

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

alias ls='ls --color=auto'
alias cgrep='grep -r -n --color'
alias make='make -j 6'
alias exit='history -c; exit'
alias pingtest='ping -c 3 www.google.com'
alias cmus-play='cmus-remote -p'
alias cmus-pause='cmus-remote -u'
alias cmus-stop='cmus-remote -s'
alias cmus-next='cmus-remote -n'
alias cmus-prev='cmus-remote -r'

PS1='\[\e[1;32m\][\u@\h\[\e[1;34m\] \W\[\e[1;32m\]]\$\[\e[m\] '
EDITOR=vim
PATH=$PATH:/usr/local/cross/bin
export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib/
