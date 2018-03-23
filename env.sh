# history management
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export HH_CONFIG=hicolor

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:${PATH}"

# iTerm2 custom title on each tab
#export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007";history -a; history -n'
PS1="\[\e[1;30m\]\u @ \w\[\e[m\] \\$ "

alias reload="source ~/.bash_profile"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlahp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi=vim
alias svi='sudo vim'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias root='sudo -i'
alias df='df -H'
alias du='du -ch'

# pbcopy < ~/.ssh/id_rsa.pub

# opens file or folder with sublime
alias s='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# public ip
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
# local ip(s)
alias ip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# removes a bunch of crap from your finder
#alias cleanup="find . -name '*.DS_Store' -type f -ls -delete && find . -name 'Thumbs.db' -type f -ls -delete"

alias qfind="find . -name "                 # qfind:    Quickly search for file

# Git
alias gits='git status'
alias gitp='git pull --rebase'

# kubectl
alias k8='kubectl'
alias k8pods='kubectl get pods --all-namespaces'


# tab completion for ssh hosts
if [ -f ~/.ssh/known_hosts ]; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

# Tab complete for sudo
complete -cf sudo

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

zipf () { zip -r "$1".zip "$1" ; }


#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   ---------------------------
#   SEARCHING
#   ---------------------------
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# Key binding for hh
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi
