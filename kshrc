:
#
#
# .kshrc     -- Commands executed by each Korn shell at startup
#
#       @(#)  kshrc  1.0 21/01/10
#
#
#

# Allow to store Hisory
HISTFILE="$HOME/.ksh_history"
HISTSIZE=1000

# Arrow keys!!!
set -o emacs

alias __A=
alias __B=
alias __C=
alias __D=

alias _A=
alias _B=
alias _C=
alias _D=

#Header:
lastlogin=$(last -1 -R  $USER | head -n -1 | cut -c 23-| cut -c -15)
echo "${USER} logged in at $lastlogin, tty=$(tty | sed -e "s:/dev/::")"
ksh --version
echo "------------------------------------------------------------------------"
if [ -z "$VISUAL" -a -z "$EDITOR" ]; then
	set -o emacs
fi

#PLAN 9 stuff
PLAN9=/usr/local/plan9 export PLAN9
PATH=$PATH:$PLAN9/bin export PATH

# Making prompt
PS1="$(print -n "[\033[1;33m${USER}\033[00m:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "\033[1;36m~${PWD#$HOME}"; else; print -n "\033[1;36m$PWD";fi;print -n "\033[00m]$ ")"

function _cd {
	\cd "$@"
	PS1=$(
	print -n "[\033[1;33m${USER}\033[00m:"
	if [[ "${PWD#$HOME}" != "$PWD" ]]
	then
		print -n "\033[1;36m~${PWD#$HOME}"
	else
		print -n "\033[1;36m$PWD"
	fi
	print -n "\033[00m]$ "
	)
}

alias cd=_cd

cd "$PWD"
