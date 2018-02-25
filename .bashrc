export PYTHONPATH="/usr/local/mercurial/mercurial-1.4.2/lib/python2.6/site-packages"

function interactive()
{
	if [[ $- = *i* ]]; then 
		return 1
	else 
		return 0
	fi
}

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
# Shell is non-interactive.  Be done now!
	return
fi

############### HOME CONF ###############
HOME_CONF=${HOME}/.config
HOME_LIB=${HOME}/lib
HOME_BIN=${HOME}/bin
#########################################
#proxy conf#
#export http_proxy="http://lvs.cs.bgu.ac.il:8081"
#export ftp_proxy="lvs.cs.bgu.ac.il:8081"


############## host specific conf ##############3
if [ -e /etc/profile ]; then
	. /etc/profile
fi
###############################################3

############### MISC CONF ################
PATH=${HOME_BIN}:${PATH:=""}:/usr/local/mercurial/contrib
EDITOR="vim"
VISUAL=$EDITOR

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib

export EDITOR VISUAL HOME_CONF HOME_LIB 
export HOME_BIN HOSTNAME
export LC_ALL=C

#export number of processors on linux
if [ -f /proc/cpuinfo ]; then
	export NUM_OF_CORES=$(grep processor /proc/cpuinfo | wc -l)
else
	export NUM_OF_CORES=1
fi

# Define some colors first: for the prompt..
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
magenta='\e[0;35m'
MAGENTA='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
white='\e[0;37m'
white='\e[1;37m'
NC='\e[0m'              # No Color

ulimit -S -c unlimited          # want coredumps
set -o notify
#set -o noclobber
#set -o ignoreeof
set -o nounset
#set -o xtrace          # useful for debuging

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
#shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # necessary for programmable completion
shopt -u huponexit


#MAILCHECK=5
#MAILPATH=~/mail/Inbox?"you have mail"

HISTIGNORE="&:bg:fg:ll:h:cd"
HISTFILE="${HOME_CONF}/history/$(hostname)"
#this controls auto logout.
export HISTIGNORE HISTFILE 
export HISTFILESIZE=10000

# source my functions:
. ${HOME_CONF}/functions.sh

trap _exit EXIT

powerprompt     # this is the default prompt - might be slow

#source aliases:
. ${HOME_CONF}/aliases.sh

#source completion:
. ${HOME_CONF}/complete.sh
#and if bash-completion is installed
[ -f /etc/profile.d/bash-completion ] && . /etc/profile.d/bash-completion

export GF_PLAZA="relay2:172.30.35.139:@app_2_gf"
export DEV_PROJECTS="/home/tzachar/repos/"

umask 0077

#source host specific config. do this last, to allow overrides
[ -f .config/hosts/${HOSTNAME}.conf ] && . .config/hosts/${HOSTNAME}.conf


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
