#!/bin/zsh

# --- 1. Run Python Logic (Detection, Installation, Updates) ---

if [[ -f ~/.config/binaries.py ]]; then
    python3 ~/.config/binaries.py
fi

# --- 2. Simple Aliases: [alias_name]="target_binary" ---

typeset -A simple_aliases
simple_aliases=(
    ["dig"]="doggo"
    ["cp"]="cpx"
)

# Simple Aliases
for alias_name target_bin in ${(kv)simple_aliases}; do
    if command -v "$target_bin" &> /dev/null; then
        alias "$alias_name"="$target_bin"
    fi
done

# --- 3. Shell Configuration (Env Vars & Complex Aliases) ---

# Complex Logic for 'bat'
export BAT_THEME=kanagawa
if command -v bat &> /dev/null; then
    alias rcat="$(whence -p cat)"
    alias cat="$(whence -p bat) --theme kanagawa"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi
