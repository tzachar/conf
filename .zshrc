# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"
# ZSH_THEME="cypher"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
#DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

#must be b4 plugins
if [ -d ~/.pyenv/bin ] ; then
	export PYTHON_CONFIGURE_OPTS="--enable-shared"
	export PATH="/home/tzachar/.pyenv/bin:$PATH"
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#
# custom plugins:
# https://github.com/zsh-users/zsh-autosuggestions
plugins=(pyenv web-search zsh git sudo ubuntu history history-substring-search ssh-agent zsh-autosuggestions tmux)

source $ZSH/oh-my-zsh.sh

if [ -d ~/.pyenv/bin ] ; then
	PROMPT="%{${fg[green]}%}($(pyenv_prompt_info))%{${reset_color}%} %m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "
else
	PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "
fi

# Customize to your needs...
#

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa google_compute_engine

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "[A" history-substring-search-up
bindkey "[B" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# bind ctrl + space to execute current auto suggestion
bindkey '^ ' autosuggest-execute

#dont want sahring of history
setopt no_sharehistory

#complete in middle of word
setopt complete_in_word

#expand ~ after a '='
setopt magic_equal_subst

#specify which chars to skip over:
export WORDCHARS='*?_-.[]~/&;!#$%^(){}<>'

#make zsh not expand wildcards in ssh,scp commands:
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema \
'[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp rsync)'

############### HOME CONF ###############
HOME_CONF=${HOME}/.config
HOME_LIB=${HOME}/lib
HOME_BIN=${HOME}/bin
#########################################

export PATH=${HOME_BIN}:${PATH:=""}:/usr/local/mercurial/contrib:/sbin
EDITOR="vim"
VISUAL=$EDITOR
PAGER='less -r'

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/cuda/lib64/ 

export HOSTNAME=$(hostname)
export EDITOR VISUAL HOME_CONF HOME_LIB 
export HOME_BIN PAGER
#export LC_ALL=C
export LC_ALL=en_US.UTF-8
export PYTHONPATH=${PYTHONPATH}:${HOME}/python:~/work/vault/code/vault_py:~/work/vault/code/vault_py/apis:~/work/vault/code/

#export number of processors on linux
if [ -f /proc/cpuinfo ]; then
	export NUM_OF_CORES=$(grep processor /proc/cpuinfo | wc -l)
else
	export NUM_OF_CORES=1
fi

ulimit -S -c unlimited          # want coredumps
#
#source aliases:
. ${HOME_CONF}/aliases.sh
. ${HOME_CONF}/functions.sh

export MANPATH=${MANPATH}:${HOME}/man

#
#source host specific config. do this last, to allow overrides
if [[ -f .config/hosts/${HOSTNAME}.conf ]]; then . .config/hosts/${HOSTNAME}.conf; fi

#control the terminal:
stty -ixon

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$PATH:$HOME/npm/bin
export NODE_PATH="$NODE_PATH:$HOME/npm/lib/node_modules"

[ -f sqlworkbench/sqlwbconsole.sh ] &&\
	PATH=${PATH}:${HOME}/sqlworkbench

[ -f /usr/local/google/google-cloud-sdk/path.zsh.inc ] && \
	source /usr/local/google/google-cloud-sdk/path.zsh.inc
[ -f /usr/local/google/google-cloud-sdk/completion.zsh.inc ] && \
	source /usr/local/google/google-cloud-sdk/completion.zsh.inc

#export TERM=xterm
export COLORTERM=gnome-terminal
#export NVIM_TUI_ENABLE_TRUE_COLOR=1


#qfc:
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

export CUDA_INC_DIR=/usr/local/cuda/include/                                                                                                       
export CUDA_HOME=/usr/local/cuda/ 

export TERM=xterm-256color

# remove alias to ag
unalias -m ag

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

