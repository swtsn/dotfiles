# The following lines were added by compinstall
zstyle :compinstall filename '/Users/swatson/.zshrc'

# Git completion
fpath=(~/.zsh $fpath)

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

bindkey "^R" history-incremental-search-backward
export EDITOR=vim
export PATH=/usr/local/linkedin/bin:/usr/local/Cellar/ruby/2.0.0-p247/bin:$PATH:/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin

# Reduce key response lag
export KEYTIMEOUT=1

alias glog="git log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
alias gclean="git clean -fxd --exclude=config/"

# ls

alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -Al'              
alias lx='ls -lXB'              
alias lk='ls -lSr'              
alias lc='ls -lcr'     
alias lu='ls -lur'    
alias lr='ls -lR'               
alias lt='ls -ltr'              
alias lm='ls -l |more'         

# PROMPT
# Refresh prompt line
setopt PROMPT_SUBST
# Load colors
autoload -Uz colors && colors

# Git branch prompt string
function git_branch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Replicate CSSH in tmux
function multi_ssh()
{
    tmux new-window -n tssh ssh $1
    shift
    for HOST in "$@"; do
        tmux split-window -t :$ ssh $HOST
        tmux select-layout -t :$ tiled
    done
    tmux setw -t :$ synchronize-panes on
}
alias tssh=multi_ssh```

# prompt line
PROMPT='%D{%H:%M:%S} [%F{green}%n%f@%F{green}%m%f %F{cyan}%1~%f%F{magenta}$(git_branch)%f]> '
