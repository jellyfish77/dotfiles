# Aliases and functions

#git
#alias g=git
#When invoked without arguments g will do a short Git status, otherwise it will just pass on the given arguments to the git command. Status is likely to the be Git command one will execute the most, hence this simple enhancement does prove very useful in practice.
#alias g='_f() { if [[ $# == 0 ]]; then git status --short --branch; else git "$@"; fi }; _f'
alias g='_f() { if [[ $# == 0 ]]; then git status; else git "$@"; fi }; _f'
complete -o default -o nospace -F _git g

#list command
alias ls='ls --color --classify --human-readable'
alias ll='ls -l'
#alias ll='ls -al --color=auto'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'
#list files larger than x bytes, e.g. llfs +10k
alias llfs='_f(){ find . -type f -size "$1" -exec ls --color --classify --human-readable -l {} \; ; }; _f'

#easy nav
alias -- -='cd -'   # toggle between current and last dir (-)
alias ..='cd ..'
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# handy short cuts #
alias s=sudo
alias c='clear'
alias h='history'
alias j='jobs -l'
alias n='nano'
alias sn='sudo nano'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

alias ports='netstat -tulanp'

## pass options to free ##
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'
 
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
 
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

#Confirm unsafe file operations
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

# More color aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

######################################
# Functions
#
# Can be called as commands in bash
######################################

pe() {
	echo "Printing Environment..."
	bash -c printenv | grep -i "$1";
	printf "Matches: " && bash -c printenv | grep -i -c "$1";
}

#reload bash profile
rl() {
	. ~/.profile
}

foo(){ echo "Hello"; }
