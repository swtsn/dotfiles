# EXPORTS
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin

BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'
export PS1="\t [\[${GREEN}\]\u\[${NC}\]@\[${GREEN}\]\h\[${NC}\] \[${CYAN}\]\W\[${NC}\]]> "

# 'ls' aliases
alias ls='ls -G'
alias ll='ls -l'
alias lf='ls -F'
alias la='ls -Al'              
alias lx='ls -lXB'              
alias lk='ls -lSr'              
alias lc='ls -lcr'     
alias lu='ls -lur'    
alias lr='ls -lR'               
alias lt='ls -ltr'              
alias lm='ls -l |more'         

# Environment
alias activate='source ~/dev/env/bin/activate'

gfind () { if [ $# -lt 2 ]; then files="*"; search="${1}"; else files="${1}"; search="${2}"; fi; find -P . -name "$files" -a ! -wholename '*/.*' -exec grep -Hin ${3} "$search" {} \; ; }
