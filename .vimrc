"set term=xterm-color
"set terminal for 256 colors
set t_ku=[A
set t_kd=[B
set t_kl=[D
set t_kr=[C
set t_Co=256

let mapleader=","

syntax on		" Default to no syntax highlightning 

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Raimondi/delimitMate'
Plugin 'sjl/gundo.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mutewinter/swap-parameters'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'vim-scripts/MPage'
Plugin 'vim-scripts/FSwitch'
Plugin 'tpope/vim-repeat'
"Plugin 'svermeulen/vim-easyclip'
"Plugin 'arecarn/crunch'
Plugin 'jamessan/vim-gnupg'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'headerguard' 
Plugin 'DeonPoncini/includefixer' 
Plugin 'fisadev/vim-ctrlp-cmdpalette' 
Plugin 'sgur/ctrlp-extensions.vim' 
"disabled for now, need clickable.vim which i do not like..
"Plugin 'Rykka/riv.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'sjl/splice.vim'
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-commentary'
Plugin 'ingo-library'
Plugin 'TextTransform'
Plugin 'saihoooooooo/glowshi-ft.vim'
"Plugin 'Rykka/clickable.vim'
"Plugin "Rykka/clickable-things"
"Plugin "Rykka/os.vim"
Plugin 'haya14busa/incsearch.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'godlygeek/csapprox'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'vimoutliner/vimoutliner'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'vim-scripts/DirDo.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'tommcdo/vim-exchange'
call vundle#end()

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ruler		" Show the line and column numbers of the cursor 
set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set nocompatible	" Use Vim defaults (much better!)
" use Q for formatting, not ex-mode:
noremap Q gq
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
set so=5 "cursor cant get closer than 5 lines to end of screen
set spelllang=en
set hidden

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

augroup ftypeOptions
autocmd!
autocmd BufEnter *.cpp,*.h,*.c,*.cu,*.proto,*.hpp set cinoptions=:0,p0,t0,l1,g0,(0,W8,m1 cinwords=if,else,while,do,for,switch,case formatoptions=tcqrl cinkeys=0{,0},0),0#,!^F,o,O,e,: cindent showmatch noexpandtab tabstop=8 
autocmd BufEnter *.cu set syntax=cpp

autocmd BufEnter *.java ab sop System.out.println
autocmd BufEnter *.java set formatoptions=tcqr cindent showmatch noexpandtab tabstop=8
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd BufEnter *.tex set makeprg=~/bin/latexmake.sh
autocmd BufEnter *.tex nnoremap <silent> <Leader>l :execute "!~tzachar/bin/pdflatexmake.sh " . expand("%:r") <cr><cr>
autocmd BufEnter *.tex nnoremap <silent> <Leader>x :execute "!~tzachar/bin/latexmake.sh " . line("."). " " . expand("%:r")<cr><cr>
autocmd BufEnter *.tex setlocal spell spelllang=en
autocmd BufEnter *.tex nnoremap =  <ESC>:call FormatLatexPar(0)<CR>

"latex box:
autocmd BufEnter *.tex inoremap [[ \begin{
autocmd BufEnter *.tex inoremap ]] <Plug>LatexCloseCurEnv

autocmd BufEnter *.heb.tex setlocal spell spelllang=he
autocmd BufEnter *.heb.tex set rightleft

augroup end

function! UpdateTimeStamp()
	let l:winview = winsaveview()
	%s/LAST_CHANGE "\zs[^"]*/\= strftime("%c")/e
	%s/LAST_CHANGE_DATE "\zs[^"]*/\= strftime("%Y%m%d")/e
	call winrestview(l:winview)
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

noremap mm :make -j4 <cr>

"noremap <C-k> :tabnew 
"noremap <C-h> :tabprev <cr>
"noremap <C-j> :tabclose <cr>
"noremap <C-l> :tabnext <cr>
noremap <C-l> :bnext<cr>
noremap <C-j> :bprev<cr>
noremap <C-k> :b#<cr>
"noremap <leader>bn :bNext <cr>
"noremap <leader>bp :bprevious <cr>
"noremap <leader>bl :ls <cr>

"buffergatror oftions
let g:buffergator_viewport_split_policy="B"
let g:buffergator_split_size="10"

"spelling highlight
hi SpellBad term=reverse ctermfg=white ctermbg=darkred guifg=#ffffff guibg=#7f0000 gui=underline
hi SpellCap guifg=#ffffff guibg=#7f007f
hi SpellRare guifg=#ffffff guibg=#00007f gui=underline
hi SpellLocal term=reverse ctermfg=black ctermbg=darkgreen guifg=#ffffff guibg=#7f0000 gui=underline

noremap <C-F11> :wa<cr>:!gen_ctags<cr>:cs reset<cr>
noremap cc :wa<cr>:!gen_ctags<cr>:cs reset<cr>
augroup popups
	au!
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup end

"jumpt to last opened location
augroup lastopen
	au!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g'\"" | endif
augroup end

nnoremap <C-N> :cn<CR>
nnoremap <C-@><C-N> :cN<CR>


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
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
			\ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
			\ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
			\ }
			"\'AcceptSelection("t")':['<cr>'],
			"\'AcceptSelection("e")':['<c-x>'],
nnoremap <Leader>pf :CtrlPFunky<cr>
nnoremap <Leader>pF :execute 'CtrlPFunky ' . expand('<cword>')<cr>
nnoremap <Leader>pp :CtrlP<cr>
nnoremap <Leader>pb :CtrlPBuffer<cr>
nnoremap <Leader>pr :CtrlPMRU<cr>

" narrow the list down with a word under cursor
nnoremap <Leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>'

"multipage editing
nnoremap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

"pymode config
let g:pymode_lint_ignore="E501"
let g:pymode_rope=0

"FSwitch
"Switch to the file and load it into the current window >
nnoremap <silent> <Leader>of :FSHere<cr>
nnoremap <silent> <Leader>oo :FSHere<cr>
nnoremap <silent> <Leader>ol :FSRight<cr>
augroup mycppfiles
  au!
  au BufEnter *.h,*.hpp let b:fswitchdst  = 'cpp,cc,C'
  au BufEnter *.h,*.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
au BufEnter *.c,*.cpp let b:fswitchdst = 'h,hpp'
au BufEnter *.c,*.cpp let b:fswitchlocs = 'reg:|src|include/**|'
augroup END

"folding highlight
hi Folded term=standout ctermfg=LightBlue ctermbg=DarkGrey

"localvimrc
let g:localvimrc_sandbox=0

"for highlight text
highlight Search cterm=NONE ctermfg=black ctermbg=red

" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.2)<cr>
"nnoremap <silent> N   N:call HLNext(0.2)<cr>
"highlight MyGroup ctermbg=white ctermfg=red
"function! HLNext (blinktime)
	"let [bufnum, lnum, col, off] = getpos('.')
	"let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	"let target_pat = '\c\%#'.@/
	"let ring = matchadd('MyGroup', target_pat, 101)
	"redraw
	"exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	"call matchdelete(ring)
	"redraw
"endfunction

"open up .vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<cr>G
"source up .vimrc
nnoremap <leader>vs :source $MYVIMRC<cr>

let g:glowshi_ft_no_default_key_mappings=1
inoremap jj <esc>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
"for glowshi
map <unique>f <plug>(glowshi-ft-f)
map <unique>F <plug>(glowshi-ft-F)
map <unique>t <plug>(glowshi-ft-t)
map <unique>T <plug>(glowshi-ft-T)
"map : <plug>(glowshi-ft-repeat)
"map <unique>, <plug>(glowshi-ft-opposite)

"remove mappings:
"inoremap <esc> <nop>
"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <up> <nop>

"add a ; at the end of the line
inoremap <leader>; <esc>mTA;<esc>`Ta
nnoremap <leader>; mTA;<esc>`T

cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

"tell ctrl-p to use 'JazzCore/ctrlp-cmatcher'
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Map key to toggle opt
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  "exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <Leader>s spell
MapToggle <Leader>a paste

function! PerlFormat(str)
  let out = system('perl -e "use Text::Autoformat; autoformat {break=>break_wrap, all=>1, left=>1, right=>80};"', a:str)
  return out
endfunction
call TextTransform#MakeMappings('', '<Leader>f', 'PerlFormat') 

set background=dark
colorscheme candycode
set background=dark

"for incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
