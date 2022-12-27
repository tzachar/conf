# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tzachar/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tzachar/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tzachar/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/tzachar/fzf/shell/key-bindings.zsh"
