" screen
if match($TERM, "screen") != -1
	set term=xterm-color
	"set terminal for 256 colors
endif
set t_Co=256

let mapleader=","

call pathogen#infect()
syntax on		" Default to no syntax highlightning 

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'wincent/Command-T'
"Bundle 'Raimondi/delimitMate'
Bundle 'sjl/gundo.vim'
Bundle 'mileszs/ack.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mutewinter/swap-parameters'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'vim-scripts/MPage'
Bundle 'vim-scripts/FSwitch'

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ruler		" Show the line and column numbers of the cursor 
set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set nocompatible	" Use Vim defaults (much better!)
" use Q for formatting, not ex-mode:
map Q gq
set backspace=2		" allow backspacing over everything in insert mode
set smartindent
set autoindent		" always set autoindenting on
set nobackup		" do not keep a backup file
set nonumber
set textwidth=80	" set text width to 70 chars.
set tabpagemax=30       "how many tabs to allow at max
set hlsearch
set viminfo='50,\"100,:50,%,n~/.viminfo
set laststatus=2
set encoding=utf-8


function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

"search for tags first in the file dir, then current dir, then boost:
set tags=./tags,tags,/usr/local/boost/tags,/home/tzachar/.vim/tags/stl_tags

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" set filetypes 
filetype on
filetype plugin indent on

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
  au! BufRead,BufNewFile *.pp setfiletype puppet 
augroup end

autocmd BufEnter *.cpp,*.h,*.c,*.cu,*.proto,*.hpp set cinoptions=:0,p0,t0,l1,g0,(0,W8,m1 cinwords=if,else,while,do,for,switch,case formatoptions=tcqrl cinkeys=0{,0},0),0#,!^F,o,O,e,: cindent showmatch noexpandtab tabstop=8 
autocmd BufEnter *.cu set syntax=cpp

autocmd BufEnter *.java ab sop System.out.println
autocmd BufEnter *.java set formatoptions=tcqr cindent showmatch noexpandtab tabstop=8
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd BufEnter *.tex set makeprg=~/bin/latexmake.sh
autocmd BufEnter *.tex map ;p :execute "!~tzachar/bin/pdflatexmake.sh " . expand("%:r") <cr><cr>
autocmd BufEnter *.tex map ;; :execute "!~tzachar/bin/latexmake.sh " . line("."). " " . expand("%:r")<cr><cr>
autocmd BufEnter *.tex setlocal spell spelllang=en
autocmd BufEnter *.tex nnoremap =  <ESC>:call FormatLatexPar(0)<CR>

autocmd BufEnter *.heb.tex setlocal spell spelllang=he
autocmd BufEnter *.heb.tex set rightleft

function! UpdateTimeStamp()
	%s/LAST_CHANGE "\zs[^"]*/\= strftime("%c")/
endfunction

augroup TimeStamp
	au!
	au! BufWritePre,FileWritePre,FileAppendPre *.cpp,*.c,*.py,*.h,*.hpp :call UpdateTimeStamp()
augroup END

" vim -b : edit binary using xxd-format!
augroup Binary
au!
au BufReadPre  *.bin let &bin=1
au BufReadPost *.bin if &bin | %!xxd
au BufReadPost *.bin set ft=xxd | endif
au BufWritePre *.bin if &bin | %!xxd -r
au BufWritePre *.bin endif
au BufWritePost *.bin if &bin | %!xxd
au BufWritePost *.bin set nomod | endif
augroup END

map mm :make -j4 <cr>

map <C-up> :tabnew 
map <C-left> :tabprev <cr>
map <C-down> :tabclose <cr>
map <C-right> :tabnext <cr>

map <C-f> :!perl -e "use Text::Autoformat; autoformat {break=>break_wrap, all=>1, left=>1, right=>80};"<cr><cr>
map ss :setlocal spell spelllang=en<cr>

"spelling highlight
hi SpellBad term=reverse ctermfg=white ctermbg=darkred guifg=#ffffff guibg=#7f0000 gui=underline
hi SpellCap guifg=#ffffff guibg=#7f007f
hi SpellRare guifg=#ffffff guibg=#00007f gui=underline
hi SpellLocal term=reverse ctermfg=black ctermbg=darkgreen guifg=#ffffff guibg=#7f0000 gui=underline

map <C-F11> :wa<cr>:!gen_ctags<cr>:cs reset<cr>
map cc :wa<cr>:!gen_ctags<cr>:cs reset<cr>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"jumpt to last opened location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

nmap <C-N> :cn<CR>
nmap <C-@><C-N> :cN<CR>


"for syntastics:
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': ['ruby', 'php', 'python'],
			\ 'passive_filetypes': [] }

"for commant-T
let g:CommandTAcceptSelectionTabMap='<CR>'
let g:CommandTAcceptSelectionMap='<C-o>'
let g:CommandTMaxFiles=30000

"for Switch:
nnoremap - :Switch<cr>

"make Enter work like C-Y in popup menue
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"powerline
set noshowmode
let g:Powerline_symbols = 'unicode'

"gundo
nnoremap <F5> :GundoToggle<CR>

"ctrlp config
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_extensions = ['funky']
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_prompt_mappings = {
			\'AcceptSelection("t")':['<cr>'],
			\'AcceptSelection("e")':['<c-x>'],
			\ }
nnoremap <Leader>pf :CtrlPFunky<cr>
nnoremap <Leader>pF :execute 'CtrlPFunky ' . expand('<cword>')<cr>
nnoremap <Leader>pp :CtrlP<cr>
nnoremap <Leader>pb :CtrlPBuffer<cr>
nnoremap <Leader>pr :CtrlPMRU<cr>

" narrow the list down with a word under cursor
nnoremap <Leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>'

"multipage editing
nmap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

"pymode config
let g:pymode_lint_ignore="E501"

"FSwitch
"Switch to the file and load it into the current window >
nmap <silent> <Leader>of :FSHere<cr>
augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
  au BufEnter *.h let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
au BufEnter *.c,*.cpp let b:fswitchdst = 'h,hpp'
au BufEnter *.c,*.cpp let b:fswitchlocs = 'reg:|src|include/**|'
augroup END

