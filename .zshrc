export TERMINFO=${HOME}/.terminfo

export HISTORY_SUBSTRING_SEARCH_FUZZY=true

zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes


source ~/antigen.zsh
antigen bundle chrissicool/zsh-256color
antigen use oh-my-zsh
antigen bundle agkozak/zsh-z
# use npx histdbimport
antigen bundle larkery/zsh-histdb
mkdir -p "${HOME}"/.local/share/zsh-histdb-skim/
antigen bundle m42e/zsh-histdb-skim@main
antigen bundle git
antigen bundle sudo
antigen bundle ubuntu
antigen bundle history
antigen bundle ssh
antigen bundle ssh-agent
antigen bundle tmux
antigen bundle pipenv
antigen bundle zsh-users/zsh-completions
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle hlissner/zsh-autopair
antigen bundle MenkeTechnologies/zsh-cargo-completion

# antigen bundle yuki-yano/zeno.zsh@main

# antigen theme denysdovhan/spaceship-prompt

# these are last
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma-continuum/fast-syntax-highlighting

# antigen bundle zsh-users/zsh-history-substring-search
antigen bundle tzachar/zsh-history-substring-search

antigen theme romkatv/powerlevel10k

antigen apply

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# add custom completions
fpath=(${HOME}/.config/completions $fpath)
# zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:accept'

if [ ! -f ${HOME}/.antigen/bundles/Aloxaf/fzf-tab/modules/Src/aloxaf/fzftab.so ]; then
	build-fzf-tab-module
fi


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

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

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

# Enable edit-command-line widget
autoload edit-command-line
zle -N edit-command-line

# Bind Ctrl-X then E to edit current command line
bindkey '^Xe' edit-command-line

#make zsh not expand wildcards in ssh, scp, rsync commands:
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
expand_wildcard_commands=(scp ssh rsync)
zstyle -e :urlglobber url-other-schema \
'[[ (($expand_wildcard_commands[(I)$words[1]])) ]] && reply=("*") || reply=(http https ftp rsync)'

############### HOME CONF ###############
HOME_CONF=${HOME}/.config
HOME_LIB=${HOME}/lib
HOME_BIN=${HOME}/bin
#########################################

export PATH=${HOME_BIN}:${PATH:=""}:/sbin:~/.local/kitty.app/bin/:${HOME}/.dotnet
EDITOR="nvim"
VISUAL=$EDITOR
PAGER='less -r'

# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/cuda/lib64/

export HOSTNAME=$(hostname)
export EDITOR VISUAL HOME_CONF HOME_LIB
export HOME_BIN PAGER
#export LC_ALL=C
export LC_ALL=en_US.UTF-8
export PYTHONPATH=${PYTHONPATH}:${HOME}/python:~/work/vault/code/vault_py:~/work/vault/code/vault_py/apis:~/work/vault/code/:~/work/rust/algo
export MYPYPATH=${HOME}/.local/share/python-type-stubs

#export number of processors on linux
if [ -f /proc/cpuinfo ]; then
	export NUM_OF_CORES=$(grep processor /proc/cpuinfo | wc -l)
else
	export NUM_OF_CORES=1
fi

ulimit -S -c unlimited          # want coredumps

. ${HOME_CONF}/cargo.sh
export PATH=${PATH}:${CARGO_INSTALL_ROOT}/bin

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
if type fd &> /dev/null; then
	export FZF_DEFAULT_COMMAND="fd --type file --color=always"
	export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --ansi"
elif type ag &> /dev/null; then
	export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
export PYTHON_CONFIGURE_OPTS="--enable-shared --enable-loadable-sqlite-extensions"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -d ${PYENV_ROOT} ] ; then
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NUMEXPR_MAX_THREADS=4
enable-fzf-tab

# bind ctrl + space to execute current auto suggestion
bindkey '^ ' autosuggest-execute


backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# Alt+Left
backward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-word
}
zle -N backward-word-dir
bindkey "^[[1;3D" backward-word-dir

# Alt+Right
forward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle forward-word
}
zle -N forward-word-dir
bindkey "^[[1;3C" forward-word-dir

# deno
# if [ ! -f ${HOME}/.deno/bin/deno ]; then
# 	curl -fsSL https://deno.land/install.sh | sh
# fi
# export DENO_INSTALL="${HOME}/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Shell-GPT integration ZSH v0.1
if ! type "sgpt" > /dev/null; then
	echo "sgpt not installed. To install:"
	echo "pip install sgpt"
else
	function _sgpt_zsh() {
		if [[ -n "$BUFFER" ]]; then
		    _sgpt_prev_cmd=$BUFFER
		    BUFFER+="⌛"
		    zle -I && zle redisplay
		    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
		    zle end-of-line
		fi
	}
	zle -N _sgpt_zsh
	bindkey ^l _sgpt_zsh
	# Shell-GPT integration ZSH v0.2
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# setup go
export GOPATH="${HOME}/go"
export PATH=${PATH:=""}:"${HOME}/go/bin"


# setup 'm42e/zsh-histdb-skim'
bindkey '^R' histdb-skim-widget

# make autosuggest work with histdb
# _zsh_autosuggest_strategy_histdb_top_here() {
#     local query="select commands.argv from
# history left join commands on history.command_id = commands.rowid
# left join places on history.place_id = places.rowid
# where places.dir LIKE '$(sql_escape $PWD)%'
# and commands.argv LIKE '$(sql_escape $1)%'
# group by commands.argv order by count(*) desc limit 1"
#     suggestion=$(_histdb_query "$query")
# }
#
# export ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here

function _zsh_autosuggest_strategy_histdb_top() {
	local query
	query="
	select commands.argv from history
		left join commands on history.command_id = commands.rowid
		where commands.argv LIKE '$(sql_escape $1)%'
		order by start_time desc
		limit 1
		"
	typeset -g suggestion=$(_histdb_query "$query")
}
ZSH_AUTOSUGGEST_STRATEGY=(histdb_top)

# for this to work, you need https://github.com/tzachar/sqlite_skim
if [[ -r ${HOME}/sqlite/libsqlite_skim.so ]]; then
	function _history-substring-get-raw-matches-histdb {
		local SEP
		local query
		local what
		SEP=$(printf $'\1')
		query="
			WITH UniqueCommands AS (
			    SELECT
				commands.argv,
				MAX(history.start_time) AS last_run_time
			    FROM commands
			    LEFT JOIN history ON history.command_id = commands.rowid
			    GROUP BY commands.argv
			)
			SELECT argv
			FROM UniqueCommands
			ORDER BY
			    skim_score('$(sql_escape ${_history_substring_search_query_parts[@]})', argv) DESC,
			    last_run_time DESC
			LIMIT 50;
		"
		result=$(_histdb_query -newline $SEP "$query")
		_history_substring_search_raw_matches=(${(ps:\1:)result})
		_history_substring_search_raw_matches=(${_history_substring_search_raw_matches[@]%$'\n'})
	}

	HISTORY_SUBSTRING_SEARCH_MATCH_FUNCTION="_history-substring-get-raw-matches-histdb"
else
	echo "please install sqlite_skim: https://github.com/tzachar/sqlite_skim"
	echo "(cd /tmp; git clone https://github.com/tzachar/sqlite_skim; cd sqlite_skim; ./install.sh)"
fi

# Ensure zsh-history.db is optimized with custom indexes
if command -v sqlite3 >/dev/null 2>&1 && [[ -f "$HOME/.histdb/zsh-history.db" ]]; then
    sqlite3 "$HOME/.histdb/zsh-history.db" "
        CREATE INDEX IF NOT EXISTS idx_history_command_time ON history(command_id, start_time);
        CREATE INDEX IF NOT EXISTS idx_commands_argv ON commands(argv);
    " &>/dev/null &!
fi


# do this last, after setting up the env
. ${HOME_CONF}/binaries.sh
