:
#
#
# .kshrc     -- Commands executed by each Korn shell at startup
#
#       @(#)  kshrc  1.1 26/10/21
#
#
#

# Allow to store Hisory
HISTFILE="$HOME/.ksh_history"
HISTSIZE=1000

# Arrow keys!!!
set -o vi

alias __A=
alias __B=
alias __C=
alias __D=

alias _A=
alias _B=
alias _C=
alias _D=

# Visual mode!
EDITOR='vim'
VISUAL='vi'

# Header:
echo -e "\033[1m  Welcome to $(cat /etc/issue|cut -c -10)!\033[0m "
lastlogin=$(last -1 -R  $USER | head -n -1 | cut -c 23-| cut -c -15)
echo "  ${USER} logged in at $lastlogin, tty=$(tty | sed -e "s:/dev/::")"
ksh --version
echo "----------------------------------------------------------------------------"
if [ -z "$VISUAL" -a -z "$EDITOR" ]; then
	set -o vi
fi

# For Windows Subsystem for Linux
WINHOME="/mnt/c/Users/tamon"

# Making prompt
PS1="$(print -n "[\033[1;36m${USER}\033[00m:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "\033[1;33m~${PWD#$HOME}"; elif [[ "${PWD#$WINHOME}" != "$PWD" ]] then; print -n "\033[1;33-${PWD#$WINHOME}"; else; print -n "\033[1;33m$PWD";fi;print -n "\033[00m]$ ")"

function _cd {
	\cd "$@"
	PS1=$(
	print -n "[\033[1;36m${USER}\033[00m:"
	if [[ "${PWD#$HOME}" != "$PWD" ]]
	then
		print -n "\033[1;33m~${PWD#$HOME}"
	elif [[ "${PWD#$WINHOME}" != "$PWD" ]]
	then
		print -n "\033[1;33m-${PWD#$WINHOME}"
	else
		print -n "\033[1;33m$PWD"
	fi
	print -n "\033[00m]$ "
	)
}

alias cd=_cd

cd "$PWD"
alias chdir="cd $WINHOME"
alias kshupdate="/home/sebastian/Tools/kshupdate.sh"
alias ls="ls --color=auto"
alias ll="ls -lah --color=auto"
alias mastermind="/home/sebastian/Tools/mastermind"
alias make="bmake"
alias remake="bmake clean; bmake"
# After this, tmux is propperly becomes vim
alias :q="exit"
alias :vsp="tmux splitw -h -p 50"
alias :sp="tmux splitw -v -p 50"
alias :e="tmux new-window"
alias :b="tmux select-window -t"
