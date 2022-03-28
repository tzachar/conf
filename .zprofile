export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -d ${PYENV_ROOT} ] ; then
	eval "$(pyenv init --path)"
fi

