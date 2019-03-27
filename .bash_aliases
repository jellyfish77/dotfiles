# Aliases and functions

# git aliases
#alias g=git
# When invoked without arguments g will do a status, otherwise it will 
# just pass on the given arguments to the git command. Status is likely 
# to the be Git command one will execute the most, hence this simple 
# enhancement does prove very useful in practice.
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

######################################
# Functions
#
# Can be called as commands in bash
######################################

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

# Add a string to the PATH
add_to_path() {
	if contains "$PATH" "$1"
	then
		:
		#echo "$1 already in PATH"
	else
		#echo "Adding $1 to PATH..."
		export PATH=$PATH:$1
	fi
}
alias atp='add_to_path'

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
