# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tzachar/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tzachar/fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/tzachar/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/tzachar/fzf/shell/key-bindings.zsh"
