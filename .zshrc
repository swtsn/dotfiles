# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

export ZSH="$HOME/.oh-my-zsh"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export UPDATE_ZSH_DAYS=7

# Use custom theme
ZSH_THEME="swatson"

# Don't automatically update terminal title
DISABLE_AUTO_TITLE="true"

HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent)

# Configure ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent helper ksshaskpass
zstyle :omz:plugins:ssh-agent lazy yes

source $ZSH/oh-my-zsh.sh

bindkey "^R" history-incremental-search-backward

# Reduce key response lag
export KEYTIMEOUT=1

alias glog="git log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
alias gclean="git clean -fxd"

# ls
alias ls='ls --color -FG'
alias ll='ls -al'
alias la='ls -Al'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lr='ls -lR'
alias lt='ls -ltr'
alias lm='ls -l |more'

# Don't share active history between tmux windows
setopt noincappendhistory
setopt nosharehistory

# Refresh prompt line
setopt PROMPT_SUBST

# Load colors
autoload -Uz colors && colors

# Replicate CSSH in tmux
function tssh()
{
    # Rename and sync the panes in the window.
    tmux rename-window tssh
    tmux setw synchronize-panes on

    # Save the first hostname for later.
    first_host=$1
    shift

    # Open an new pane for each SSH session. We need to redraw the panes after
    # each new pane so that tmux doesn't run out of screen real estate.
    for HOST in "$@"; do
        tmux split-window ssh $HOST
        tmux select-layout tiled
    done

    # Go back to the first pane and ssh into the saved host.
    tmux select-pane -t 0
    ssh $first_host
}

# Git branch prompt string
function git_branch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# zsh completions
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh-completions:/Users/swatson/.oh-my-zsh/plugins/ssh-agent:/Users/swatson/.oh-my-zsh/plugins/git:/Users/swatson/.oh-my-zsh/functions:/Users/swatson/.oh-my-zsh/completions:/Users/swatson/.oh-my-zsh/cache/completions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:/usr/share/zsh/5.8.1/functions

  autoload -Uz compinit
  compinit -u
fi
