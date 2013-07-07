" -*- vim -*-
" FILE: "/home/wlee/.vim/plugin/DirDo.vim" {{{
" LAST MODIFICATION: "Wed, 14 Sep 2005 14:42:44 -0500 (wlee)"
" VERSION: 1.3
" (C) 2002-2005 by William Lee, <wl1012@yahoo.com>
" }}}
" 
" PURPOSE: {{{
"   - Performs Vim commands over files recursively under multiple
"   directories.
"
"   - This plugin is like :argdo but it works recursively under a directory (or
"   multiple directories).  The limitation for :argdo is that it does not glob
"   the files inside the subdirectories.  DirDo works in a similar manner but
"   you're allowed to specify multiple directories (good for refactoring code
"   and modifying files in a deep hierarchy).  DirDo also globs the files in
"   the subdirectories so you can make sure an operation is performed
"   consistantly.
"   
" REQUIREMENTS:
"   - The :argdo command in Vim 6.0
"
" USAGE:
"   Put this file in your ~/.vim/plugin directory.
"
"   The syntax of the commands:
"
"   First we need to set what directory we would like to perform this
"   command on
"
"       :DirDoDir [/my/directory1] [/my/directory2] [/my/directory3]
"
"       or
"
"       :DDD [/my/directory1] [/my/directory2] [/my/directory3]
"
"   If no argument is given, then it'll display the directories that you're
"   going to work on and let you edit them by separating them with commas
"   (',')
"
"   You can also use the following command to add a directory to the DirDoDir
"   variable:
"
"       :DirDoAdd [/my/dir]
"
"       or
"
"       :DDA [/my/dir]
"
"   If you do not give an argument to DDA, it'll add the current working
"   directory to the DirDoDir variable.
"
"   Then we set the file glob pattern
"
"       :DirDoPattern [file glob pattern1] [file glob pattern2] ...
"
"       or
"
"       :DDP [file glob pattern1] [file glob pattern2] ...
"
"   If no argument is given, then it'll display the patterns and let you
"   edit them (separate each pattern with spaces).
"
"   Then, you can do:
"
"       :DirDo [commands]
"
"       or
"
"       :DDO [commands]
"
"   to executes the commands on each file that matches the glob pattern
"   recursively under the directories that you have specified.  The format of
"   [commands] is just like what you do on :argdo. See :help argdo for
"   details.
"
"   If no argument is given, then it'll reuse the last command.
"
"   Examples:
"
"   Replace all the instaces of "Foo" to "Bar" in all the Java or C files under
"   the directory /my/directory and its subdirectories, confirming each match:
"
"       :DDD /my/directory (or just :DDD<CR> and type it in)
"       :DDP *.java *.c (or just :DDP<CR> and type it in)
"       :DDO %s/Foo/Bar/gce | update
"
"   (See :h argdo for the commands after DDO.)
"
"   Same scenario but replacing "Bar" with "Baz" without confirmation for each
"   match (note the directory and patterns are saved):
"
"       :DDO %s/Bar/Baz/ge | update
"
"   (Since 1.2) There is a command called DirDoFast where you can set the
"   directory, pattern, and command at once.  Note that your arguments need to
"   be escaped if there is an space to it, otherwise Vim will break up the
"   arguments incorrectly.  The syntax is:
"
"       :DirDoFast [directories] [patterns] command
"
"       or
"
"       :DDF [directories] [patterns] command
"
"   Multiple directories need to be separated by comma.  Patterns need to be
"   separated by spaces.  Since space is used by Vim to separate the command
"   arguments, ALL spaces in the directory, pattern, or command need to be
"   escaped.  For example, the last command using DDF would look like:
"
"   :DDF /my/directory *.java\ *.c %s/Foo/Bar/gce\ |\ update
"
"   If you only give 2 arguments to :DDF, you assume the directory is set to
"   ".".
"
"   If you only give 1 argument to :DDF, you assume the directory is set to
"   "." and the pattern is set to "*".
"
"   (Since 1.3) There is a command called DirReplace that simplifies the
"   multi-directory string replace procedure.  Essentially, it is the same
"   as executing DirDoFast with a directory, pattern, and command (as 
"   s/[regex_pattern]/[replacement/gce | update).
"
"       :DirReplace
"
"       or
"
"       :DR
"
"   You will be asked for the directories, glob patterns, regex string, and
"   the replacement.
"
"   There is an option to run DirDo with less verbosity, to toggle the
"   setting, run:
"
"       :DirDoVerbose
"
"       or
"
"       :DDV
"
"   You can also set the following variables in your .vimrc to set the default
"   directory and pattern.  This is good for pointing to the directories for
"   code refactoring:
"
"   let g:DirDoPattern = "..."
"
"   let g:DirDoDir = "..."
"
"   For example, if you want by default have the command apply on all your C,
"   C++, and Java source, you can set the DirDoPattern to:
"
"   let g:DirDoPattern = "*.c *.cpp *.java"
"
"   If you want to apply your changes to /dir1, /dir2, and /dir3, you can do:
"
"   let g:DirDoDir = "/dir1,/dir2,/dir3"
"
" CREDITS:
"
"   Please mail any comment/suggestion/patch to 
"
"   William Lee <wl1012@yahoo.com>
"
"   (c) 2002-2003. This script is under the same copyright as Vim itself.
"
" THANKS:
"
"   Lijian Liu and Thomas Nickl for reporting numerous bugs.
"
" HISTORY:
"  1.3  - 9/14/2005 Added the DirReplace command
"  1.2  - 6/12/2003 Added the DirDoFast command so you can set directory,
"  pattern, and command at once.  Fixed bug where the unix hidden file will
"  not show up in the file list.  Fixed bug where ~ in the path does not work.
"  1.1  - 8/19/2002 Added DirDoAdd command to add directory
"  1.0  - 8/7/2002 Initial release
"

" Mappings
command! -nargs=* DDO call <SID>DirDo(<f-args>)
command! -nargs=* DirDo call <SID>DirDo(<f-args>)

command! -nargs=* DDF call <SID>DirDoFast(<f-args>)
command! -nargs=* DirDoFast call <SID>DirDoFast(<f-args>)

command! -nargs=* DR call <SID>DirReplace(<f-args>)
command! -nargs=* DirReplace call <SID>DirReplace(<f-args>)

command! -nargs=0 DDV call <SID>DirDoVerbose()
command! -nargs=0 DirDoVerbose call <SID>DirDoVerbose()

command! -nargs=* -complete=dir DDD call <SID>DirDoDir(<f-args>)
command! -nargs=* -complete=dir DirDoDir call <SID>DirDoDir(<f-args>)

command! -nargs=* -complete=dir DDA call <SID>DirDoAdd(<f-args>)
command! -nargs=* -complete=dir DirDoAdd call <SID>DirDoAdd(<f-args>)

command! -nargs=* DDP call <SID>DirDoPattern(<f-args>)
command! -nargs=* DirDoPattern call <SID>DirDoPattern()

" Sort the import with preferences to the java.* classes
"
if !exists("g:DirDoPattern")
    let g:DirDoPattern = ""
endif

if !exists("g:DirDoDir")
    let g:DirDoDir = ""
endif

if !exists("g:DirDoVerbose")
    let s:Verbose = 1
else
    let s:Verbose = g:DirDoVerbose
endif

let s:LastCommand = ""

" Ask to enter the file
let s:AskFile = 1

" Ask to cancel the operation
let s:CancelFile = 0

" Convenience method to do a search and replace
fun! <SID>DirReplace(...)
    let ddd = input("Directories (use ',' to separate multiple entries): " , g:DirDoDir)
    let ddp = input("Glob patterns (use ' ' to separate multiple entries): " , g:DirDoPattern)
    let searchRegex = input("Search Regex: ")
    let replaceStr = input("Replace with: ")
    let cfm = confirm("Confirm each replace?", "&Yes\n&No", 1)
    let setStr = "ge"
    if (cfm == 1)
        let setStr = "gce"
    endif
    let cmd = "s/" . searchRegex . "/" . replaceStr . "/" . setStr . "|update"
    call <SID>DirDoFast(ddd, ddp, cmd, 0)
endfun

" Sets the directory
fun! <SID>DirDoDir(...)
    " Constructs the arguments as a comma separated list
    if (a:0 != 0)
        let ctr = 1
        let g:DirDoDir = ""
        while (ctr <= a:0)
            if (g:DirDoDir != "")
                let g:DirDoDir = g:DirDoDir . ','
            endif
            let g:DirDoDir = g:DirDoDir . a:{ctr}
            let ctr = ctr + 1
        endwhile
    else
        " Edit the directories
        let g:DirDoDir = input ("Set DirDo directories (use ',' to separate multiple entries): " , g:DirDoDir)
    endif
endfun

" Adds to the DirDo directory
fun! <SID>DirDoAdd(...)
    " Constructs the arguments as a comma separated list
    if (a:0 != 0)
        let ctr = 1
        let add_dir = ""
        while (ctr <= a:0)
            if (add_dir != "")
                let add_dir = add_dir . ','
            endif
            let add_dir = add_dir . a:{ctr}
            let ctr = ctr + 1
        endwhile
        if (g:DirDoDir == "")
            let g:DirDoDir = add_dir
        else
            let g:DirDoDir = g:DirDoDir . ',' . add_dir
        endif
    else
        " Add the current directory of the current file to the DirDo Path
        let c_dir = getcwd()
        echo ("Adding to DirDoDir: " . c_dir)
        if (g:DirDoDir == "")
            let g:DirDoDir = c_dir
        else
            let g:DirDoDir = g:DirDoDir . ',' . c_dir
        endif
    endif
endfun

" Sets the pattern
fun! <SID>DirDoPattern(...)
    " Constructs the arguments as a comma separated list
    if (a:0 != 0)
        let ctr = 1
        let g:DirDoPattern = ""
        while (ctr <= a:0)
            if (g:DirDoPattern != "")
                let g:DirDoPattern = g:DirDoPattern . ' '
            endif
            let g:DirDoPattern = g:DirDoPattern . a:{ctr}
            let ctr = ctr + 1
        endwhile
    else
        " Edits the pattern
        let g:DirDoPattern = input("Set DirDo glob patterns (use ' ' to separate multiple entries): " , g:DirDoPattern)
    endif
endfun

" Sets the directoris that we would like to work on
fun! <SID>DirDoVerbose()
    if (s:Verbose == 1)
        let s:Verbose = 0
        echo "Setting DirDo verbosity to off."
    else
        let s:Verbose = 1
        echo "Setting DirDo verbosity to on."
    endif
endfun

" Trim the string with white spaces in front or at the end
fun! <SID>TrimStr(str)
    let rtn = substitute(a:str, '\(^\s*\|\s$\)', '', 'g')
    return rtn
endfun

" A one line command that does it all
fun! <SID>DirDoFast(...)
    if (a:0 == 4)
        let g:DirDoDir = a:1
        let g:DirDoPattern = a:2
        let cmd = a:3
        let cfm = a:4
    elseif (a:0 == 3)
        let g:DirDoDir = a:1
        let g:DirDoPattern = a:2
        let cmd = a:3
        let cfm = 1
    elseif (a:0 == 2)
        let g:DirDoDir = "."
        let g:DirDoPattern = a:1
        let cmd = a:2
        let cfm = 1
    elseif (a:0 == 1)
        let g:DirDoDir = "."
        let g:DirDoPattern = "*"
        let cmd = a:1
        let cfm = 1
    else
        echo "Error: Missing argument for: DirDoFast \"[dir]\" \"[patterns]\" \"[cmd]\" "
        return
    endif

    if (cmd == "")
        echo "You have to specify a command for DirDo!"
        return 1
    endif

    echo "Directories: " . g:DirDoDir
    echo "Glob Pattern: " . g:DirDoPattern
    echo "Command: " . cmd
    if (cfm == 1)
        let in = confirm("Run DirDo?", "&Yes\n&No", 1)
        if (in != 1)
            return 0
        endif
    endif

    let s:MatchRegexPattern = <SID>GetRegExPattern()
    echo "MatchRegexPattern is " . s:MatchRegexPattern
    let currPaths = <SID>TrimStr(g:DirDoDir)
    " See if currPaths has a ',' at the end, if not, we add it.
        "echo "currPaths begin is " . currPaths
    if (match(currPaths, ',$') == -1)
        let currPaths = currPaths . ','
    endif

    let fileCount = 0

    while (currPaths != "")
        let sepIdx = stridx(currPaths, ",")
        " Gets the substring exluding the newline
        let currPath = strpart(currPaths, 0, sepIdx)
        let currPath = <SID>TrimStr(currPath)
        let currPath = fnamemodify(expand(currPath, ":p"), ":p")
        if (s:Verbose == 1)
            echo "Applying command recursively in root path: " . currPath . " ..."
        endif
        let currPaths = strpart(currPaths, sepIdx + 1, strlen(currPaths) - sepIdx - 1)
        let fileCount = fileCount + <SID>DirDoHlp(currPath, cmd)
    endwhile
    " Reset the argument list
    argl
    echo "Done.  Applied command on " . fileCount . " files."
endfun

" Recursively apply the commands to the list of directories in DirDoDir
fun! <SID>DirDo(...)
    " Update the AskFile to true
    let s:AskFile = 1
    let s:CancelFile = 0

    " Save current document
    update

    " Constructs the arguments
    let ctr = 1
    let cmd = ""
    if (a:0 != 0)
        while (ctr <= a:0)
            if (cmd != "")
                let cmd = cmd . ' '
            endif
            let cmd = cmd . a:{ctr}
            let ctr = ctr + 1
        endwhile
        let s:LastCommand = cmd
    else
        let cmd = s:LastCommand
    endif
    call <SID>DirDoFast(g:DirDoDir, g:DirDoPattern, cmd)
endfun

" Turns the global glob pattens into a regex pattern
fun! <SID>GetRegExPattern()
    " Trim the string
    let matchPat = <SID>TrimStr(g:DirDoPattern)
    if (matchPat == "")
        " Default to all file
        matchPat = '*'
    endif
    let matchPat = matchPat . ' '
    " We would like to change the * to .* and escape the . in the glob pattern
    " this will work on most cases...
    let patStr = substitute(matchPat, '\.', '\\.', 'g')
    let patStr = substitute(patStr, '\*', '.*', 'g')
    let patStr = substitute(patStr, '\s', '$\\|', 'g')
    " get rid of the extra \\| at the end
    let patStr = substitute(patStr, '\\|$', '', '')
    
    return ('\(' . patStr . '\)')
endfun

" The helper function to apply the command to a directory
fun! <SID>DirDoHlp(cpath, cmd)
    "echo "Arguments " . a:cpath . " cmd is " . a:cmd
    "we would like to ignore path that ends with [\/].. and [\/].
    if (match(a:cpath, '\([\\/]\.$\|[\\/]\.\.$\|^\.\.$\|^\.$\)') > -1)
        return 0
    endif
    if (!isdirectory(a:cpath) && match(a:cpath, s:MatchRegexPattern) > -1)
        "echo "Is not dir... " . a:cpath
        let i = 1
        if (s:CancelFile == 1)
            return 0
        endif
        if (s:Verbose == 1 && s:AskFile == 1)
            let i = confirm("Apply command to file " . a:cpath . "?", "&Yes\nYes for &All Files\n&No\n&Cancel", 1)
        endif
        if (i == 4)
            let s:CancelFile = 1
            return 0
        endif
        if (i == 3)
            return 0
        endif
        if (i == 2)
            let s:AskFile = 0
        endif

        exe "argl " . a:cpath
        exe "argdo " . a:cmd
        return 1
    else
        if (isdirectory(a:cpath))
            let files = glob(a:cpath . "/*")
            let files = files . "\n"
            " we would like to get the hidden files also
            let hfiles = glob(a:cpath . "/.*")
            let hfiles = hfiles . "\n"
            let files = files . hfiles
            let fileCtr = 0
            "while (files != "" && files !~ '^\n+$')
            while (files != "" && files != "\n")
                let cut = stridx(files, "\n")
                let file = strpart(files, 0, cut)
                let files = strpart(files, cut+1)
                let fileCtr = fileCtr + <SID>DirDoHlp(file, a:cmd)
            endwhile
            return fileCtr
        endif
    endif
endfun

