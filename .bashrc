# Sourced when you open a terminal in non-login interactive mode (i.e. when you
# open a bash session inside the terminal program inside a graphical session, 
# you are already "logged in" to the graphical session and are not logging in 
# to the bash session inside the terminal).

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

#############################################################
# OQ changes below this point
#############################################################

# Add bash aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Set the default editor
export EDITOR=nano
export VISUAL='nano'

# Tilix config
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
		source /etc/profile.d/vte.sh
fi

########################################## 
# History config...
##########################################

export HISTTIMEFORMAT="%d/%m/%y %T "

# Avoid succesive duplicates in the bash command history.
#export HISTCONTROL=ignoredups

# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

HISTCONTROL='erasedups:ignoreboth'
HISTIGNORE=?:??
HISTFILESIZE=99999
HISTSIZE=99999
shopt -s histappend histverify

##########################################
# Seafly Prompt config...
##########################################

# OQ - force display prompt on new line
shopt -s promptvars
PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1

#seafly prompt, see: https://github.com/bluz71/bash-seafly-prompt
#export SEAFLY_SHOW_USER=0
#export SEAFLY_PROMPT_SYMBOL=">"
#export SEAFLY_PS2_PROMPT_SYMBOL=">"
#export SEAFLY_GIT_PREFIX="("
#export SEAFLY_GIT_SUFFIX=")"
#export SEAFLY_GIT_DIRTY="*"
#export SEAFLY_GIT_STASH="$"
#export SEAFLY_GIT_AHEAD=">"
#export SEAFLY_GIT_BEHIND="<"
#export SEAFLY_GIT_DIVERGED="<>"
export SEAFLY_NORMAL_COLOR="$(tput bold; tput setaf 63)"
export SEAFLY_ALERT_COLOR="$(tput bold; tput setaf 202)"
export SEAFLY_HOST_COLOR="$(tput bold; tput setaf 242)"
#export SEAFLY_GIT_COLOR="$(tput bold; tput setaf 99)"
export SEAFLY_GIT_COLOR="$(tput bold; tput setaf 4)"
#export SEAFLY_PATH_COLOR="$(tput bold; tput setaf 70)"
export SEAFLY_PATH_COLOR="$(tput bold; tput setaf 3)"
export SEAFLY_SHOW_USER=1
export PROMPT_DIRTRIM=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
. ~/.bash-seafly-prompt/command_prompt.bash

#OQ - set red prompt 
#export PS1="\e[1;33m[\u@\h \W]\$ \e[m "
#export PS1="\e[1;33m[\u@\h:\w]\$ \e[m "
export PS1="\e[1;33m[\u:\w]\$ \e[m "
#export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "
#export PS1="\[$(tput setaf 1)\]\u@\h:\w $ \[$(tput sgr0)\]"
#export PS1="[\[\e[1;34m\]$WINDOW\[\e[0m\]:\[\e[1;$UCOL\]\$(sens)\[\e[0m\]$SEP\u@\[\e[1;$ENV\]\h.$ENAME\[\e[0m\]:\[\e[1;31m\]\$(get_branch)\[\e[0m\] \w]\\$ ";

#note, this prevents seafly working
#export PROMPT_COMMAND="date +%H:%M:%S"
#same line
#export PROMPT_COMMAND="echo -n [$(date +%H:%M:%S)]"

#shorten deep prompts (\w)
#PROMPT_DIRTRIM=4






