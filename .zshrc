# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERMINFO=/home/tzachar/.local/kitty.app/lib/kitty/terminfo

source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle sudo
antigen bundle ubuntu
antigen bundle history
antigen bundle ssh
antigen bundle ssh-agent
antigen bundle tmux
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Aloxaf/fzf-tab

# antigen theme denysdovhan/spaceship-prompt

# these are last
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen theme romkatv/powerlevel10k

antigen apply

# zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:accept'

DISABLE_AUTO_TITLE="true"
ZSH_TMUX_FIXTERM="false"
ZSH_TMUX_FIXTERM_WITH_256COLOR='tmux-256colors'

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "

# Customize to your needs...
#

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa google_compute_engine

# ignore double slashes in file completion
zstyle :completion:\* squeeze-slashes true

# set autosuggest color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245,underline,bold"

# use emacs keys
bindkey -e

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "[A" history-substring-search-up
bindkey "[B" history-substring-search-down

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# want share_history
setopt share_history

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

export PATH=${PATH:=""}:/sbin:${HOME_BIN}:~/.local/kitty.app/bin/:${HOME}/.dotnet:${HOME}/.cargo/bin
EDITOR="nvim"
VISUAL=$EDITOR
PAGER='less -r'

# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/cuda/lib64/

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
if [[ -f ~/.config/hosts/${HOSTNAME}.conf ]]; then . ~/.config/hosts/${HOSTNAME}.conf; fi

#control the terminal:
# stty -ixon

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
# export COLORTERM=gnome-terminal
#export NVIM_TUI_ENABLE_TRUE_COLOR=1

export CUDA_INC_DIR=/usr/local/cuda/include/
export CUDA_HOME=/usr/local/cuda/
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TF_CPP_MIN_LOG_LEVEL=3

# export TERM=xterm-256color

# remove alias to ag
unalias -m ag

export FZF_DEFAULT_OPTS='--tiebreak=end'
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
export PYTHON_CONFIGURE_OPTS="--enable-shared --enable-loadable-sqlite-extensions"
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d ${PYENV_ROOT} ] ; then
	export PATH="${PYENV_ROOT}/bin:$PATH"
	# eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NUMEXPR_MAX_THREADS=4
enable-fzf-tab

# bind ctrl + space to execute current auto suggestion
bindkey '^ ' autosuggest-execute

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
