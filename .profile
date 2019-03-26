# Sourced when you log into a graphical session (I.e. the x-session
# (gnome-session) process) - thus inherited to all processes within the 
# graphical session, including non-login shells (terminal emulators)

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#############################################################
#OQ My Changes below this point
#############################################################

SCRIPTS="/home/otto/scripts"
PATH="$PATH:$SCRIPTS"
export PATH

PATH="$PATH:/opt/apache-maven-3.6.0/bin"
export PATH

PATH="$PATH:/opt/fuse-7.2.0/bin"
export PATH

INSTALL_DIR='opt'
JAVA_DIR='java/current'
JAVA_DIR="/$INSTALL_DIR/$JAVA_DIR"
export JAVA_HOME=$JAVA_DIR

# OQ - For sublime text to be default
#export EDITOR=/opt/sublime_text/sublime_text -w -n
#export EDITOR='subl -w -n'
#export EDITOR='subl -w'
#export VISUAL=$EDITOR


