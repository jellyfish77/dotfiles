# Aliases and functions

########################################################################
#
# Git aliases
#
########################################################################

#alias g=git
# When invoked without arguments g will do a status, otherwise it will 
# just pass on the given arguments to the git command. Status is likely 
# to the be Git command one will execute the most, hence this simple 
# enhancement does prove very useful in practice.
#alias g='_f() { if [[ $# == 0 ]]; then git status --short --branch; else git "$@"; fi }; _f'
alias g='_f() { if [[ $# == 0 ]]; then git status; else git "$@"; fi }; _f'
complete -o default -o nospace -F _git g

# [g]it [f]ind [e]mpty - search for empty dirs (git will not add to tree)
alias gfe='find . -type d -empty -not -path "./.git/*" -not -path "./.metadata/*" -not -path "*/target/*"'
# [g]it [k]eep [e]mpty - add .gitkeep files to all empty dirs to make git to add to tree
alias gke='find . -type d -empty -not -path "./.git/*" -not -path "./.metadata/*" -not -path "*/target/*" -exec touch {}/.gitkeep \;'


########################################################################
#
# Command Aliases
#
########################################################################

#list command
alias l='ls -la | grep "^d" && ls -la | grep "^-" && ls -la | grep "^l"'
alias ls='ls --color --classify --human-readable'
alias ll='ls -l'
#alias ll='ls -al --color=auto'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'
#list files larger than x bytes, e.g. llfs +10k
alias llfs='_f(){ find . -type f -size "$1" -exec ls --color --classify --human-readable -l {} \; ; }; _f'

alias tt='tree'
alias ta='tree -alpugifhDFC'

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
alias v='vim'
alias sv='sudo vim'
alias t='type'			# show what an alias expands to

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
  
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## set some other defaults ##
alias df='df -H'
alias du='du -ch'

#Confirm unsafe file operations
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

alias ks='kill -9' #  send kill signal to process id, e.g. ks 3301 (kill cannot be intercepted; it will pulll the plug on a process)
alias kt='kill -15' # send terminate signal to process id, e.g. kt 3301 (terminate can be intercepted, allowing process to shutdown gracefully)


########################################################################
#
# Function Definitions
#
# Can be called as commands in bash
#
########################################################################

# print environment
pe() {
	bash -c printenv | grep -i "$1";
	printf "Matches: " && bash -c printenv | grep -i -c "$1";
}

#display ports
dp() {
	bash -c 'netstat -tulanp' | grep -i "$1";
	printf "Matches: " && bash -c 'netstat -tulanp' | grep -i -c "$1";
}

#reload bash profile
rl() {
	. ~/.profile
}

# Add a dir (string) to the PATH (if not already in PATH)
add_to_path() {
	printf "Adding dir to PATH: \'$1\'... "
	if contains "$PATH" "$1"
	then
		:
		printf "[Already in PATH]\n"
	else
		export PATH=$PATH:$1
		printf "Done.\n"
	fi
}
alias atp='add_to_path'

# set and export an environment variable (if not already set to value)
# params:
# $1 = variable name
# $2 = value to set
export_var() {
	varname=$1
	printf "Setting $varname to: \'$2\'... "
	if contains ${!varname} $2
	then
		:
		printf "[Already set]\n"
	else
		export $1=$2
		printf "Done.\n"
	fi
}

contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

#start find changes
sfch() {
	touch /tmp/MARK	
}

# find changed files since 
fch() {
	path="$HOME/logs"
	if (( $# != 1 )); then
		fn="file-changes"
	else
		fn=$1
	fi
	file_path="$path/$fn.log"
	#echo $file_path
	date=$(date -r /tmp/MARK +"%Y-%m-%d %H:%M:%S")
    printf "Files accessed or modified after: $date...\n" | tee "$file_path"
	sudo find / -path /run -prune -o -path /tmp -prune -o -path /sys -prune -o -path /proc -prune -o -newercm /tmp/MARK -printf "[Acc: %AY-%Am-%Ad %AH:%AM:%.2AS] [Mod: %TY-%Tm-%Td %TH:%TM:%.2TS] %p\n" | tee -a "$file_path"
	printf "Entries written to '$file_path'\n"
}

foo(){ echo "Hello"; }
