#-------------------
# Personnal Aliases
#-------------------

#embed pwd in xterm titlebar:

#function cd_titlebar(){
	#cd "$@"
	#echo -e -n "\e]0;$USER@$HOSTNAME:$PWD\007" 
	#set +o noglob
#}

#cd_titlebar .

#alias cd='set -o noglob;cd_titlebar'
alias m='make'
alias rm='rm -irf'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # Pretty-print using enscript
alias du='du -kh'
alias df='df -kTh'
alias grep='grep --color=auto'
alias g='grep'
alias md='mkdir'
alias wget='wget -l5 -r -nc -t0 -np -nd'
alias calc='set -o noglob;_calc'
alias pconsole="~/bin/pconsole.sh"
alias parallel="parallel --tmpdir /run/shm --compress"

if ! type "exa" > /dev/null; then
	echo "exa not installed (install using cargo). resorting to plain ls"
	alias ls='ls -hF --color'
	alias ll='ls -al'
else
	alias ls='exa'
	alias ll='exa -al -snew'
fi

alias tree='tree -Csu'   
# spelling typos - highly personnal :-)
alias xs='cd'
alias vf='cd'
alias kk='ll'

#urxvt 
alias urxvt='urxvt -fn "xft:Bitstream Vera Sans Mono:pixelsize=18" -bg black -fg wheat'

#make:
alias make="make -j${NUM_OF_CORES}"
alias dmake="RELEASE_DIR=/home/scratch/QA-Zone make"
alias dcmake="cmake -DCMAKE_BUILD_TYPE=Debug"
alias rcmake="cmake -DCMAKE_BUILD_TYPE=Release"

alias cq=condor_q

alias sq='squeue -o "%.7i %.9P %.20j %.8u %.2t %.10M %.6D %R"'
alias vi='nvim'
