#!/usr/bin/env python3
import subprocess
import shutil
import sys
import os
from pathlib import Path
from datetime import datetime, timedelta

# --- 1. Configuration Data ---

class Binary:
    def __init__(self, name, type, pkg=None, install_cmd=None, update_cmd=None, post_install=None, toolchain=None):
        self.name = name
        self.type = type  # cargo, pip, apt, rustup, custom
        self.pkg = pkg or name
        self.install_cmd = install_cmd
        self.update_cmd = update_cmd
        self.post_install = post_install
        self.toolchain = toolchain

    def is_installed(self):
        return shutil.which(self.name) is not None

    def install(self):
        print(f"\033[34m-> Installing {self.name}...\033[0m")
        if self.type == "cargo":
            tc = f" {self.toolchain}" if self.toolchain else ""
            cmd = f"cargo{tc} install {self.pkg}"
        elif self.type == "pip":
            cmd = f"pip install {self.pkg}"
        elif self.type == "apt":
            cmd = f"sudo apt install -y {self.pkg}"
        elif self.type == "rustup":
            cmd = f"rustup component add {self.pkg}"
        elif self.type == "custom":
            cmd = self.install_cmd
        else:
            return

        subprocess.run(cmd, shell=True)  # ty: ignore
        if self.post_install:
            subprocess.run(self.post_install, shell=True)

    def update(self):
        print(f"\033[34m-> Updating {self.name}...\033[0m")
        if self.type == "cargo":
            # cargo install updates if needed
            tc = f" {self.toolchain}" if self.toolchain else ""
            cmd = f"cargo{tc} install {self.pkg}"
        elif self.type == "pip":
            cmd = f"pip install --upgrade {self.pkg}"
        elif self.type == "apt":
            cmd = f"sudo apt install --only-upgrade -y {self.pkg}"
        elif self.type == "rustup":
            cmd = f"rustup component add {self.pkg}"
        elif self.type == "custom":
            cmd = self.update_cmd if self.update_cmd else self.install_cmd
            if not cmd:
                print(f"\033[90m    (Custom install: please update {self.name} manually)\033[0m")
                return
        else:
            return

        subprocess.run(cmd, shell=True)
        if self.post_install:
            subprocess.run(self.post_install, shell=True)


BINARIES = [
    Binary("cargo", "custom", install_cmd="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh", update_cmd="rustup update"),
    Binary("bat", "cargo", post_install="bat cache --build"),
    Binary("delta", "cargo", pkg="git-delta"),
    Binary("duf", "apt"),
    Binary("mold", "custom", install_cmd="echo 'See https://github.com/rui314/mold for install instructions'"),
    Binary("pyenv", "custom", install_cmd="curl https://pyenv.run | bash && echo 'REMINDER: Install libsqlite-dev and libz-dev'"),
    Binary("tree-sitter", "custom", install_cmd="echo 'See https://github.com/tree-sitter/tree-sitter'"),
    Binary("glances", "pip"),
    Binary("asciinema", "cargo", pkg="--locked --git https://github.com/asciinema/asciinema"),
    Binary("agg", "cargo", pkg="--git https://github.com/asciinema/agg"),
    Binary("rust-analyzer", "rustup"),
    Binary("rg", "cargo", pkg="ripgrep"),
    Binary("mergiraf", "cargo", pkg="--locked mergiraf"),
    Binary("difft", "cargo", pkg="--locked difftastic"),
    Binary("lspmux", "cargo"),
    Binary("doggo", "custom", install_cmd="curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh"),
    Binary("sk", "cargo", pkg="skim", toolchain="+nightly"),
    Binary("cpx", "cargo"),
    Binary("stylua", "cargo"),
    Binary("claude-chill", "cargo", pkg="--git https://github.com/davidbeesley/claude-chill"),
]

# --- 2. System Health Checks ---

def health_check():
    paths = [
        "/usr/share/terminfo/t/tmux-256color",
        "/usr/lib/terminfo/t/tmux-256color"
    ]
    if not any(os.path.exists(p) for p in paths):
        print("\033[31m[!] Missing tmux-color256 terminfo.\033[0m Try: sudo apt install ncurses-term")

# --- 3. Logic ---

def main():
    health_check()

    # Install missing
    missing = [b for b in BINARIES if not b.is_installed()]
    if missing:
        print("\033[33m󱐋 The following tools are missing:\033[0m")
        for b in missing:
            print(f"  • {b.name}")

        response = input("Would you like to install them now? (y/N): ").lower()
        if response == 'y':
            for b in missing:
                b.install()
                if b.name == "cargo":
                    # Load cargo env for current process
                    cargo_env = Path.home() / ".cargo" / "env"
                    if cargo_env.exists():
                        # Simple way to get env vars into python is tricky,
                        # but we can just add to PATH for subsequent calls
                        os.environ["PATH"] += os.pathsep + str(Path.home() / ".cargo" / "bin")
            print("\033[32m Installation attempts complete.\033[0m")
        else:
            print("\033[90mSkipping installation.\033[0m")

    # Periodic update
    marker = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "binaries_update_marker"
    marker.parent.mkdir(parents=True, exist_ok=True)

    should_update = False
    if not marker.exists():
        should_update = True
    else:
        mtime = datetime.fromtimestamp(marker.stat().st_mtime)
        if datetime.now() - mtime > timedelta(days=7):
            should_update = True

    if should_update:
        print("\033[33m󱐋 It has been over a week since installed binaries were updated.\033[0m")
        response = input("Would you like to update them now? (y/N): ").lower()
        if response == 'y':
            marker.touch()
            for b in BINARIES:
                if b.is_installed():
                    b.update()
            print("\033[32mUpdate attempts complete.\033[0m")
        else:
            print("\033[90mSkipping updates.\033[0m")

if __name__ == "__main__":
    main()
