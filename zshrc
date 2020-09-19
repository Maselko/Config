#    ____  _____/ /_  __________
#   /_  / / ___/ __ \/ ___/ ___/
#  _ / /_(__  ) / / / /  / /__
# (_)___/____/_/ /_/_/   \___/

# Prompt stuff
PROMPT='%F{039}%n%f:[%F{220}%1~%f]%# '

# my extra commands
lsd(){ cd $@ && ls -G }
alias ls="ls -G"
alias ll="ls -alG"
alias ram="sudo purge"
alias git-clone="cd /Users/sebastian/Documents/Github; git clone"
alias gfort="gfortran"
alias nano="/usr/local/Cellar/nano/5.2/bin/nano"

# to make my Tools run
alias fort="~/Tools/fort.sh"
alias postman="~/Tools/postman.sh"
alias blinker="sudo ~/Tools/blinker.py"
alias juno="~/Tools/juno.sh"


# Conda stuff
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sebastian/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sebastian/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/sebastian/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sebastian/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

