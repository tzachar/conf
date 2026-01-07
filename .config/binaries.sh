# use bat instead of cat if available
export BAT_THEME=kanagawa
if command -v bat >/dev/null 2>&1; then
	# Save the original system `cat` under `rcat`
	alias rcat="$(whence -p cat)"

	# For all other systems
	alias cat="$(whence -p bat) --theme kanagawa"
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export MANROFFOPT="-c"
else
	echo "Please install bat: cargo install bat"
fi


# check if we have tmux terminfo
if [[ ! -f /usr/share/terminfo/t/tmux-256color ]] && [[ ! -f /usr/lib/terminfo/t/tmux-256color ]]; then
	echo "Missing tmux-color256 terminfo. Try installing ncurses-term"
fi

if ! command -v delta >/dev/null 2>&1; then
	echo "please install delta: cargo install git-delta"
fi

if ! command -v duf >/dev/null 2>&1; then
	echo "please install duf: sudo apt install duf"
fi

if ! command -v cargo >/dev/null 2>&1; then
	echo "please install rust: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
fi

if ! command -v mold >/dev/null 2>&1; then
	echo "please install mold. see https://github.com/rui314/mold"
fi

if ! command -v pyenv >/dev/null 2>&1; then
	echo "please install pyenv: curl https://pyenv.run | bash"
	echo "also make sure you have libsqlite-dev, libz-dev"
fi

if ! command -v tree-sitter >/dev/null 2>&1; then
	echo "please install tree-sitter: https://github.com/tree-sitter/tree-sitter"
fi

if ! command -v glances >/dev/null 2>&1; then
	echo "please install glances: pip install glances"
fi

# record terminal
if ! command -v asciinema >/dev/null 2>&1; then
	echo "please install asciinema: cargo install --locked --git https://github.com/asciinema/asciinema "
fi
if ! command -v agg >/dev/null 2>&1; then
	echo "please install agg: cargo install --git https://github.com/asciinema/agg"
fi

if ! command -v rust-analyzer >/dev/null 2>&1; then
	echo "please install rust-analyzer: rustup component add rust-analyzer"
fi

if ! command -v rg >/dev/null 2>&1; then
	echo "please install ripgrep: cargo install ripgrep"
fi

if ! command -v mergiraf >/dev/null 2>&1; then
	echo "please install mergiraf: cargo install --locked mergiraf"
fi

if ! command -v difft >/dev/null 2>&1; then
	echo "please install mergiraf: cargo install --locked difftastic"
fi

if ! command -v lspmux >/dev/null 2>&1; then
	echo "please install lspmux: cargo install lspmux"
fi

if ! command -v doggo >/dev/null 2>&1; then
	echo "please install doggo: curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh"
else
	alias dig='doggo'
fi
