
if [[ $OSTYPE == darwin* ]]; then
  echo "MacOS"
else
  echo "Linux"
fi


# history management
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export HH_CONFIG=hicolor

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:${PATH}"

# iTerm2 custom title on each tab
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007";history -a; history -n'
PS1="\[\e[1;32m\]\u@\h: \w\[\e[m\] \\$ "

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
alias sshdev='ssh root@linux.dev'
alias jlist='/usr/libexec/java_home -V'
alias idea='sudo bash -c "/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea"'
alias awsqa='ssh ec2-user@jump01.qa.oci.cloud.netapp.com -i ~/.ssh/devopsKeyPairEast1.pem'
alias myvms='cat ~/.ci/vms.txt'

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
alias gi='git status'
alias gitp='git pull --rebase'

# kubectl
alias k8='kubectl'
alias k8pods='kubectl get pods --all-namespaces'


# tab completion for ssh hosts
if [ -f ~/.ssh/known_hosts ]; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

# Tab complete for sudo
#complete -cf sudo

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

#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JAVA_HOME=`/usr/libexec/java_home -v 15`
export PATH_TO_FX=/Library/Java/javafx-sdk-15.0.1/lib


getvms () {
if [ "$1" == "-f" ] || [ -f "`find /Users/antons/.ci/vms.txt -mmin +120`" ]; then
  echo "Asking cloud-node-53 ..."
  curl 'https://oci-cloud-node-53.nane.openenglab.netapp.com/portal' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="90", "Google Chrome";v="90"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'DNT: 1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://oci-cloud-node-53.nane.openenglab.netapp.com/login' \
  -H 'Accept-Language: en-US,en;q=0.9,ru-RU;q=0.8,ru;q=0.7' \
  -H 'Cookie: s_fid=1BD0A8177CC7D8B9-3EF42AAB89E336FA; s_cc=true; AMCVS_98CF678254E93B1B0A4C98A5%40AdobeOrg=1; AMCV_98CF678254E93B1B0A4C98A5%40AdobeOrg=359503849%7CMCIDTS%7C18719%7CMCMID%7C91869429494829289784042132116617525908%7CMCOPTOUT-1617290410s%7CNONE%7CvVersion%7C5.0.1; intercom-id-i2d81hca=a350e89d-c570-4911-97bd-93e5f2607a4f; AMCVS_1D6F34B852784AA40A490D44%40AdobeOrg=1; AMCV_1D6F34B852784AA40A490D44%40AdobeOrg=-637568504%7CMCIDTS%7C18731%7CMCMID%7C30827945631450349520254695353114095401%7CMCAID%7CNONE%7CMCOPTOUT-1618342806s%7CNONE%7CvVersion%7C5.1.1; atlassian.sso_key=eDPpdYagtHcDg5CpH2jh8b0jJKCLPq28; session=eyJ1c2VybmFtZSI6eyIgYiI6IllXNTBiMjV6In19.E3rVxA.vQDPuiPbsxKH-9THeVybeydfc_k; atlassian.sso_req=https/%%%///confluence.ngage.netapp.com/json/startheartbeatactivity.action' \
  --compressed > ~/.ci/vms_tmp.txt

# Old code:  | grep '<td>ci-eng-antons\|<td>10.' | sed -e 's/<[^>]*>//g' | sed 'N;s/\n/ /' | sed -e 's/^[ \t]*//' | tr -s ' ' '\t' | sort > ~/.ci/vms_tmp.txt
  grep "ci-eng-antons-"  ~/.ci/vms_tmp.txt > /dev/null
  if [ $? -eq 0 ]; then
    cat ~/.ci/vms_tmp.txt | nvms.py ~/.ci/vms_desc.json | sort > ~/.ci/vms.txt
  else
    rm -rf ~/.ci/vms_tmp.txt
    echo "ERROR: Failed to get list of VMs, using old info"
  fi
fi
cat ~/.ci/vms.txt
}


sshvms () {
  if [ $# -eq 0 ]; then
  	VMIP=`txtmenu -f ~/.ci/vms.txt -w 1 -prompt "Select VM: "`
  else
	VMIP=`txtmenu -f ~/.ci/vms.txt -w 1 -select $1`
  fi
  if [ ! -z "$VMIP" ]; then
    ssh $VMIP -t bash
  fi 
}

dscvms () {
  vi ~/.ci/vms_desc.json
  if [ -f  ~/.ci/vms_tmp.txt ]; then
    cat ~/.ci/vms_tmp.txt | nvms.py ~/.ci/vms_desc.json | sort > ~/.ci/vms.txt
  else
    getvms -f
  fi
}
