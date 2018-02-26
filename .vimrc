" "set terminal for 256 colors
" if has('nvim') && match($TERM, "screen")!=-1
" 	set term=xterm
" endif

" disable python2
" let g:loaded_python_provider = 1


set t_ku=[A
set t_kd=[B
set t_kl=[D
set t_kr=[C
" set t_Co=256
set termguicolors

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

let mapleader=","

let g:plug_threads=4

let g:polyglot_disabled = ['latex']

call plug#begin('~/.vim/plugged')
" Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe', {'do': 'python3 ./install.py'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Raimondi/delimitMate'
Plug 'sjl/gundo.vim'
Plug 'mileszs/ack.vim'
Plug 'Lokaltog/vim-easymotion'
" Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-swap'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'klen/python-mode', { 'tag': 'develop' }
Plug 'tacahiroy/ctrlp-funky'
Plug 'vim-scripts/MPage'
Plug 'vim-scripts/FSwitch'
Plug 'tpope/vim-repeat'
"Plug 'svermeulen/vim-easyclip'
"Plug 'arecarn/crunch'
Plug 'jamessan/vim-gnupg'
Plug 'lervag/vimtex'
Plug 'vim-scripts/headerguard' 
Plug 'DeonPoncini/includefixer' 
Plug 'fisadev/vim-ctrlp-cmdpalette' 
Plug 'sgur/ctrlp-extensions.vim' 
"disabled for now, need clickable.vim which i do not like..
"Plug 'Rykka/riv.vim'
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'}
Plug 'sjl/splice.vim'
Plug 'wellle/targets.vim'
" use a fork of commentary
" Plug 'tpope/vim-commentary'
Plug 'jeetsukumaran/vim-commentary'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/TextTransform'
Plug 'saihoooooooo/glowshi-ft.vim'
" Plug 'haya14busa/incsearch.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'godlygeek/csapprox'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vimoutliner/vimoutliner'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DirDiff.vim'
Plug 'vim-scripts/DirDo.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'tommcdo/vim-exchange'
"Plug 'cosminadrianpopescu/vim-sql-workbench'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-surround'
Plug 'Konfekt/FastFold'
Plug 'rking/ag.vim'
Plug 'chrisbra/csv.vim'
" candycode
" Plug 'https://gist.github.com/MrElendig/1289610', 
" 	\ { 'as': 'candycode', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'

" js stuff
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'

Plug 'luochen1990/rainbow'

" true color
" Plug 'MaxSt/FlatColor'

" project wide search and replace
Plug 'eugen0329/vim-esearch'

" highligh yanked region
Plug 'machakann/vim-highlightedyank'

" close html tags
Plug 'alvan/vim-closetag'

" jump to last place
Plug 'farmergreg/vim-lastplace'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'

call plug#end()

set nocompatible	" Use Vim defaults (much better!)
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ruler		" Show the line and column numbers of the cursor 
set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set history=10000
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


"activate true color:
if has('patch-7.4.1778')
	set termguicolors
endif
if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


"search for tags first in the file dir, then current dir, then boost:
set tags=./tags,tags,/usr/local/boost/tags,/home/tzachar/.vim/tags/stl_tags

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" set filetypes 
filetype on
filetype plugin indent on

syntax on		" Default to no syntax highlightning 


augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
  au! BufRead,BufNewFile *.pp setfiletype puppet 
augroup end

augroup ftypeOptions
autocmd!
autocmd BufEnter *.cpp,*.h,*.c,*.cu,*.proto,*.hpp set cinoptions=:0,p0,t0,l1,g0,(0,W8,m1 cinwords=if,else,while,do,for,switch,case formatoptions=tcqrl cinkeys=0{,0},0),0#,!^F,o,O,e,: cindent showmatch noexpandtab tabstop=8 
autocmd BufEnter *.cpp,*.hpp :setlocal formatprg=uncrustify\ -c\ ~/.config/uncrustify.cfg\ -l\ CPP\ --no-backup\ 2>/dev/null
autocmd BufEnter *.c,*.h :setlocal formatprg=uncrustify\ -c\ ~/.config/uncrustify.cfg\ -l\ C\ --no-backup\ 2>/dev/null
autocmd BufEnter *.cu setlocal syntax=cpp
autocmd BufEnter *.cpp,*.hpp :set matchpairs+=<:> 

autocmd BufEnter *.java ab <buffer> sop System.out.println
autocmd BufEnter *.java setlocal formatoptions=tcqr cindent showmatch noexpandtab tabstop=8
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd BufEnter *.tex setlocal makeprg=~/bin/latexmake.sh
autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>l :execute "!~tzachar/bin/pdflatexmake.sh " . expand("%:r") <cr><cr>
autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>x :execute "!~tzachar/bin/latexmake.sh " . line("."). " " . expand("%:r")<cr><cr>
autocmd BufEnter *.tex setlocal spell spelllang=en
" autocmd BufEnter *.tex nnoremap <buffer> =  <ESC>:call FormatLatexPar(0)<CR>

"js
autocmd BufEnter *.html syntax sync fromstart

"latex :
autocmd BufEnter *.tex inoremap <buffer> [[ \begin{
autocmd BufEnter *.tex inoremap <buffer> \i \item
autocmd BufEnter *.tex colorscheme twilight

autocmd BufEnter *.heb.tex setlocal spell spelllang=he
autocmd BufEnter *.heb.tex setlocal rightleft


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
"make Enter work like C-Y in popup menue
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


nnoremap <C-N> :cn<CR>
nnoremap <C-@><C-N> :cN<CR>


"for syntastics:
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': ['ruby', 'php', 'python'],
			\ 'passive_filetypes': [] }

"for Switch:
let g:switch_mapping = "-"

"powerline
" set noshowmode
" let g:Powerline_symbols = 'unicode'

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'

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
nnoremap <Leader>pc :CtrlPCmdPalette<cr>
let g:ctrlp_root_markers = ['.ctrlp_ignore']

"multipage editing
nnoremap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

"pymode config
let g:pymode_python = 'python3'
let g:pymode_lint_ignore="E501"
let g:pymode_rope=0
let g:pymode_rope_completion = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_folding = 0
let g:pymode_breakpoint = 0 
let g:pymode_options_colorcolumn = 0
let g:pymode_rope_organize_imports_bind = '<Leader>ro'


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
	au BufEnter *.c,*.cpp abbrev autp auto
augroup END

if has('nvim')
	augroup nvimTerminal
		tnoremap jj <C-\><C-n>
	augroup END
endif

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

inoremap jj <esc>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"for glowshi
let g:glowshi_ft_no_default_key_mappings=1
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
function! ToggleEndChar(charToMatch)
	let l:winview = winsaveview()
	s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
	nohlsearch
	call winrestview(l:winview)
endfunction
nnoremap <Leader>; :call ToggleEndChar(';')<CR>

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

MapToggle <Leader>ss spell
MapToggle <Leader>a paste

function! PerlFormat(str)
  let out = system('perl -e "use Text::Autoformat; autoformat {break=>break_wrap, all=>1, left=>1, right=>80};"', a:str)
  return out
endfunction
call TextTransform#MakeMappings('', '<Leader>f', 'PerlFormat') 

set background=dark
" colorscheme gruvbox
colorscheme candycode
" " colorscheme flatcolor
" set background=dark

"for incsearch
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" let g:incsearch#auto_nohlsearch = 1
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)


"for dbext
let g:dbext_default_profile_Vault = 'type=SQLITE:dbname=/home/tzachar/work/vault/db/vault.sqlite'
let g:dbext_default_SQLITE_cmd_header=".mode list\n.headers ON\n"
let  g:dbext_default_DBI_max_rows = 0
augroup project_vault
	au!

	fun! SetupDbext()
		DBSetOption profile=Vault
	endfun

	" Automatically choose the correct dbext profile
	autocmd BufRead */vault/db/*.sql DBSetOption profile=Vault
	" autocmd BufRead */vault/db/*.sql SetupDbext()

        function! DBextPostResult(db_type, buf_nr)                                                                                                 
            " If dealing with a MYSQL database                                                                                                     
            if a:db_type == 'SQLITE' && line('$') >= 2 
		    execute ':silent 2,$! showtable -d\| -t -title=1'
            endif                                                                                                                                  
        endfunction                               
augroup end

augroup replacegJ

	fun! JoinSpaceless()
		if getline('.')[-1:-1] == '('
			execute 'normal! gJ'
			" Character under cursor is whitespace?
			if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
				" When remove it!
				execute 'normal dw'
			endif
		else
			execute 'normal! J'
		endif
	endfun

	" Map it to a key
	nnoremap J :call JoinSpaceless()<CR>
augroup end

set mouse=

let g:rainbow_active = 1
let g:deoplete#enable_at_startup = 1

" for eugen0329/vim-esearch
let g:esearch = {
  \ 'adapter':    'ag',
  \ 'backend':    'nvim',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}


" tag closing
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" ycm params
let g:ycm_python_binary_path = '/usr/bin/python3'

" vimtex
let g:vimtex_compiler_enabled = 0
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme


set guicursor=

" for vim-surround:
" when surrounding with 'e', ask for a wrapper
let g:surround_101 = "\1wrapper:\1(\r)"

" dont paste toggle
set pastetoggle=
