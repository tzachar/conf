#!/bin/zsh

# --- 1. Configuration Data ---

# A. Dependencies: [binary_name]="installation_command"
typeset -A dependencies
dependencies=(
    ["cargo"]="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    ["bat"]="cargo install bat"
    ["delta"]="cargo install git-delta"
    ["duf"]="sudo apt install duf"
    ["mold"]="echo 'See https://github.com/rui314/mold for install instructions'"
    ["pyenv"]="curl https://pyenv.run | bash && echo 'REMINDER: Install libsqlite-dev and libz-dev'"
    ["tree-sitter"]="echo 'See https://github.com/tree-sitter/tree-sitter'"
    ["glances"]="pip install glances"
    ["asciinema"]="cargo install --locked --git https://github.com/asciinema/asciinema"
    ["agg"]="cargo install --git https://github.com/asciinema/agg"
    ["rust-analyzer"]="rustup component add rust-analyzer"
    ["rg"]="cargo install ripgrep"
    ["mergiraf"]="cargo install --locked mergiraf"
    ["difft"]="cargo install --locked difftastic"
    ["lspmux"]="cargo install lspmux"
    ["doggo"]="curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh"
    ["sk"]="cargo +nightly install skim"
    ["cpx"]="cargo install cpx"
)

# B. Simple Aliases: [alias_name]="target_binary"
typeset -A simple_aliases
simple_aliases=(
    ["dig"]="doggo"
    ["cp"]="cpx"
)

# --- 2. System Health Checks ---

# Check for tmux terminfo
if [[ ! -f /usr/share/terminfo/t/tmux-256color ]] && [[ ! -f /usr/lib/terminfo/t/tmux-256color ]]; then
    echo "\e[31m[!] Missing tmux-color256 terminfo.\e[0m Try: sudo apt install ncurses-term"
fi

# --- 3. Missing Binary Detection ---

missing_bins=()
# We explicitly check 'cargo' first, as many other tools depend on it
check_list=("cargo" ${(k)dependencies})

for bin in ${(u)check_list}; do
    if ! command -v "$bin" &> /dev/null; then
        missing_bins+=("$bin")
    fi
done

# --- 4. Interactive Installation ---

if [[ ${#missing_bins[@]} -gt 0 ]]; then
    echo "\n\e[33m󱐋 The following tools are missing:\e[0m"
    printf "  • %s\n" "${missing_bins[@]}"

    echo -n "\nWould you like to install them now? (y/N): "
    read -q response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "\n"
        for bin in "${missing_bins[@]}"; do
            echo "\e[34m-> Installing $bin...\e[0m"

            # 1. Run the install command
            eval "${dependencies[$bin]}"

            # 2. PATH FIX: If we just installed cargo, load it immediately
            # so subsequent cargo installs in this very loop don't fail.
            if [[ "$bin" == "cargo" ]]; then
                if [[ -f "$HOME/.cargo/env" ]]; then
                    source "$HOME/.cargo/env"
                    echo "\e[32m   (Cargo environment loaded dynamically)\e[0m"
                fi
            fi
        done
        echo "\e[32m\nInstallation attempts complete.\e[0m"
    else
        echo "\n\e[90mSkipping installation.\e[0m"
    fi
fi

# --- 5. Apply Configuration & Aliases ---

# Complex Logic for 'bat'
export BAT_THEME=kanagawa
if command -v bat &> /dev/null; then
    alias rcat="$(whence -p cat)"
    alias cat="$(whence -p bat) --theme kanagawa"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# Simple Aliases
for alias_name target_bin in ${(kv)simple_aliases}; do
    if command -v "$target_bin" &> /dev/null; then
        alias "$alias_name"="$target_bin"
    fi
done
