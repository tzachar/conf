function sd()
{
	export DISPLAY=$@:0.0
	return
}

function _calc()
{
	echo $@ | bc -l
	set +o noglob
	return
}

function _exit()        # function to run upon exit of shell
{
    echo -e "${RED}Hasta la vista, baby${NC}"
}

function not_in_repo()
{
	hg branch > /dev/null 2>&1
	if [ $? -eq 0 ]; then 
		return 1
	else
		return 0
	fi
}

function hg_dirty()
{
	if not_in_repo; then
		return
	fi

	hg status 2> /dev/null \
	| awk '$1 == "?" {print "?"} $1 != "?" {print "!" }' \
	| sort | uniq | head -c1
}

function repo_test()
{
	if not_in_repo; then
		echo "not in repo"
	else
		echo "in repo"
	fi
}

function display_in_repo()
{
	if not_in_repo; then
		return
	fi
	echo ' on '
}

function hg_branch()
{
	echo "$(hg branch 2> /dev/null) "
}

P_TIME=""
function powerprompt()
{
    # notice the colors + vars are escaped, otherwise line is XX chars shorter.
    #PS1="\[\033]0;\u@\h: \w\007\]\[$blue\]\u-\[$red\]\h \[$magenta\][\A] \w \\$\[$NC\]"
    PS1="\[$yellow\]\u-\[$cyan\]\h \[$red\][\A] \w\[$green\]\$(display_in_repo)\$(hg_branch)\[$red\]\\$\[$NC\]"
}


#-----------------------------------
# File & strings related functions:
#-----------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }
# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# find pattern in a set of filesand highlight them:
function fstr()
{
	OPTIND=1
	local case=""
	local usage="fstr: find string in files.
	Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
	while getopts :it opt
	do
		case "$opt" in
		i) case="-i " ;;
		*) echo "$usage"; return;;
		esac
	done
	shift $(( $OPTIND - 1 ))
	if [ "$#" -lt 1 ]; then
		echo "$usage"
		return;
	fi
	local SMSO=$(tput smso)
	local RMSO=$(tput rmso)
	find . -type f -name "${2:-*}" -print0 | xargs -0 grep --color -sn ${case} "$1" 2>&- | less -R
}


function lowercase()  # move filenames to lowercase
{
	for file ; do
		filename=${file##*/}
		case "$filename" in
		*/*) dirname==${file%/*} ;;
		*) dirname=.;;
		esac
	nf=$(echo $filename | tr A-Z a-z)
	newname="${dirname}/${nf}"
	if [ "$nf" != "$filename" ]; then
		mv "$file" "$newname"
		echo "lowercase: $file --> $newname"
	else
		echo "lowercase: $file not changed."
	fi
	done
}



#-----------------------------------
# Process/system related functions:
#-----------------------------------

function pss() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function psa() { ps -auxwww | more ;}

function ii()   # get current host related info
{
	echo -e "\nYou are logged on ${RED}$HOST"
	echo -e "\nAdditionnal information:$NC " ; uname -a
	echo -e "\n${RED}Users logged on:$NC " ; w -h
	echo -e "\n${RED}Current date :$NC " ; date
	echo -e "\n${RED}Machine stats :$NC " ; uptime
	echo -e "\n${RED}Memory stats :$NC " ; free
	echo
}



# Misc utilities:

function repeat()       # repeat n times command
{
	local i max
	max=$1; shift;
	for ((i=1; i <= max ; i++)); do  # --> C-like syntax
		eval "$@";
	done
}

function pull_all() #pull+update all mercurial repos under current dir.
{
	for dir in $(find * -maxdepth 0 -type d); do
		cd $dir
		hg pull -u
		cd ..
	done
}

function update_nvim()
{
	pushd ~/bin
	\wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	\mv nvim.appimage nvim
	chmod a+rx nvim
	popd
}

function to_cmd()
{
	fname=$1; shift
	prefix=$1
	cat $fname | paste -d, -s | sed "s/^\|,/ $prefix /"g
}
