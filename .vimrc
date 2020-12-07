" "set terminal for 256 colors
" if has('nvim') && match($TERM, "screen")!=-1
" 	set term=xterm
" endif

" disable python2
let g:loaded_python_provider = 1
let g:python_host_prog = ""
let g:gundo_prefer_python3 = 1
let g:python3_host_prog = "/home/" . $USER . "/.pyenv/shims/python3"
" let g:python3_host_prog = "/usr/bin/python3"


set t_ku=[A
set t_kd=[B
set t_kl=[D
set t_kr=[C
" set t_Co=256
"activate true color:
if (has("termguicolors"))
	set termguicolors
endif
if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set noswapfile

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

let mapleader=","

let g:plug_threads=8


call plug#begin('~/.vim/plugged')
" color scheme
Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'Shougo/deoplete-lsp'
Plug 'Shougo/neco-vim'
Plug 'fszymanski/deoplete-emoji'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Plug 'nvim-lua/completion-nvim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }
" Plug 'nvim-treesitter/completion-treesitter'
" Plug 'steelsojka/completion-buffers'



Plug 'sjl/gundo.vim'
Plug 'mileszs/ack.vim'
Plug 'Lokaltog/vim-easymotion'
" Plug 'scrooloose/nerdcommenter'

" Plug 'machakann/vim-swap'

" ctrlp related stuff
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'tacahiroy/ctrlp-funky'
" Plug 'fisadev/vim-ctrlp-cmdpalette' 
" Plug 'sgur/ctrlp-extensions.vim' 
" Plug 'nixprime/cpsm', {'do': './install.sh'}

"fzf
Plug 'junegunn/fzf', { 'dir': '~/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'vim-scripts/ExtractMatches'
" Plug 'vim-scripts/MPage'
Plug 'vim-scripts/FSwitch'
Plug 'tpope/vim-repeat'
"Plug 'svermeulen/vim-easyclip'
"Plug 'arecarn/crunch'
Plug 'jamessan/vim-gnupg'
Plug 'lervag/vimtex'
Plug 'vim-scripts/headerguard' 
Plug 'DeonPoncini/includefixer' 
"disabled for now, need clickable.vim which i do not like..
"Plug 'Rykka/riv.vim'
Plug 'sjl/splice.vim'
Plug 'wellle/targets.vim'
" use a fork of commentary
" Plug 'tpope/vim-commentary'
Plug 'jeetsukumaran/vim-commentary'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/TextTransform'
Plug 'saihoooooooo/glowshi-ft.vim'
" Plug 'haya14busa/incsearch.vim'
" Plug 'sheerun/vim-polyglot'
"Plug 'godlygeek/csapprox'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vimoutliner/vimoutliner'
Plug 'vim-scripts/a.vim'
" Plug 'vim-scripts/DirDiff.vim'
" Plug 'vim-scripts/DirDo.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'tommcdo/vim-exchange'
"Plug 'cosminadrianpopescu/vim-sql-workbench'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-surround'
" Plug 'Konfekt/FastFold'
Plug 'rking/ag.vim'
" Plug 'chrisbra/csv.vim'
" candycode
" Plug 'https://gist.github.com/MrElendig/1289610', 
" 	\ { 'as': 'candycode', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }

" Plug 'junegunn/vim-slash'

" js stuff
" Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'

Plug 'luochen1990/rainbow'

" true color
" Plug 'MaxSt/FlatColor'

" project wide search and replace
" Plug 'eugen0329/vim-esearch'

" highligh yanked region
Plug 'machakann/vim-highlightedyank'

" close html tags
Plug 'alvan/vim-closetag'

" jump to last place
Plug 'farmergreg/vim-lastplace'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'

" show changes in vcs
Plug 'mhinz/vim-signify'

" python formatter
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" Plug 'sbdchd/neoformat'

" Plug 'tzachar/vim-fsub', { 'for': 'python' }

Plug 'godlygeek/tabular'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'yuttie/comfortable-motion.vim'

" add cmd utils as vim commands
Plug 'tpope/vim-eunuch'

" show mappings
Plug 'liuchengxu/vim-which-key'

" syntax ranges
Plug 'vim-scripts/SyntaxRange'

" firevim
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"python format
" Plug 'psf/black', { 'for': 'python' }

" align on character
Plug 'tommcdo/vim-lion'

"strip whitespace on save
Plug 'axelf4/vim-strip-trailing-whitespace'

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'Iron-E/nvim-highlite'

"lsp config
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'

" git
Plug 'tpope/vim-fugitive'

" iron, repr integration
Plug 'hkupty/iron.nvim'

call plug#end()

set nocompatible	" Use Vim defaults (much better!)
set showcmd		" Show (partial) command in status line.
set mouse=
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
set modeline

" default yank to clip
set clipboard+=unnamed

" this controls saving swap and highlighting var under cursor
set updatetime=200

" deoplete:
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_hasSnippetsSupport = 0
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ deoplete#manual_complete()

call deoplete#custom#option('auto_complete_delay', 100)
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" set tex flavor:
let g:tex_flavor = 'latex'

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

" fun! TrimWhitespace()
"     let l:save = winsaveview()
"     keeppatterns %s/\s\+$//e
"     call winrestview(l:save)
" endfun

augroup ftypePython
	autocmd!
	au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 number
	au FileType python setlocal number
	" autocmd BufWritePre *.py :call TrimWhitespace()
	autocmd FileType python set textwidth=120	" set text width to 70 chars.
	autocmd FileType python nnoremap <Leader>fs :FToggle<Cr>
	" autocmd FileType python nnoremap <silent> =     :.YAPF <CR>
	" autocmd FileType python vnoremap <silent> =     :YAPF <CR>

" 	autocmd FileType python nnoremap <Leader>j :<C-U>YAPF<Cr>
" 	autocmd FileType python vnoremap <Leader>j :YAPF<Cr>
" 	autocmd FileType python nnoremap <Leader>fs :FToggle<Cr>
augroup end

augroup lspFiles
	autocmd!
	autocmd FileType python,html,json nnoremap <silent> <c-]>    <cmd>lua vim.lsp.buf.declaration()<CR>
	autocmd FileType python,html,json nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
	autocmd FileType python,html,json nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
	autocmd FileType python,html,json nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	"autocmd FileType python nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	autocmd FileType python,html,json nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	autocmd FileType python,html,json nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
	autocmd FileType python,html,json nnoremap <silent> gj    <cmd>lua vim.lsp.buf.code_action()<CR>
	autocmd FileType python,html,json nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

	let g:diagnostic_enable_virtual_text = 1
	let g:diagnostic_insert_delay = 1

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

	autocmd BufEnter *.tex setlocal makeprg=~/bin/latexmake.sh
	autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>l :execute "!~tzachar/bin/pdflatexmake.sh " . expand("%:r") <cr><cr>
	autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>x :execute "!~tzachar/bin/latexmake.sh " . line("."). " " . expand("%:r")<cr><cr>
	autocmd BufEnter *.tex setlocal spell spelllang=en
	" autocmd BufEnter *.tex nnoremap <buffer> =  <ESC>:call FormatLatexPar(0)<CR>

	"js
	autocmd BufEnter *.html syntax sync fromstart
	autocmd BufEnter *.html set ft=html.javascript
	autocmd FileType html set textwidth=10000

	"latex :
	autocmd BufEnter *.tex inoremap <buffer> [[ \begin{
	autocmd BufEnter *.tex inoremap <buffer> \i \item
	"autocmd BufEnter *.tex colorscheme twilight

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

nnoremap <C-N> :cn<CR>
nnoremap <C-@><C-N> :cN<CR>


"for Switch:
let g:switch_mapping = "-"

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'angr'

"gundo
nnoremap <F5> :GundoToggle<CR>

" fzf config
nnoremap <Leader>pb :Buffers<cr>
nnoremap <Leader>pp :Files<cr>
nnoremap <Leader>pf :BTags<cr>

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'down': '~40%' }

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let opts = {
        \ 'relative': 'cursor',
  	\ 'col': 0,
	\ 'row': 1,
        \ 'width': 80,
        \ 'height': 20,
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

"multipage editing
nnoremap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>


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
endif

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
call TextTransform#MakeMappings('', '<Leader>fp', 'PerlFormat') 

" set background=dark
" colorscheme gruvbox
" colorscheme candycode
let g:onedark_color_overrides = {
\ "black": {"gui": "#000000", "cterm": "0", "cterm16": "0" },
\ "white": { "gui": "wheat", "cterm": "145", "cterm16": "7" },
\}
colorscheme onedark
" colorscheme highlite
highlight Normal guibg=black guifg=wheat
"for highlight text
highlight Search guibg=red

" set background=dark

"for dbext
let g:dbext_default_profile_Vault = 'type=SQLITE:dbname=/home/' . $USER . '/work/vault/db/vault.sqlite'
let g:dbext_default_SQLITE_cmd_header=".mode list\n.headers ON\n"
let g:dbext_default_DBI_max_rows = 0
augroup project_vault
	au!

	fun! SetupDbext()
		DBSetOption profile=Vault
	endfun

	" Automatically choose the correct dbext profile
	autocmd BufRead */vault/db/*.sql DBSetOption profile=Vault
	" autocmd BufRead */vault/db/*.sql SetupDbext()

	function! DBextPostResult(db_type, buf_nr)
		if a:db_type == 'SQLITE' && line('$') >= 2 
			execute ':silent 2,$! showtable -d\| -t -title=1'
		endif
	endfunction                               
augroup end

augroup replacegJ

	fun! JoinSpaceless()
		if getline('.')[-1:-1] == '(' || getline('.')[-1:-1] == '['
			execute 'normal! gJ'
			" Character under cursor is whitespace?
			if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
				" Then remove it!
				execute 'normal dw'
			endif
		else
			execute 'normal! J'
		endif
	endfun

	" Map it to a key
	nnoremap J :call JoinSpaceless()<CR>
augroup end

let g:rainbow_active = 1

" tag closing
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" vimtex
let g:vimtex_compiler_enabled = 0
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif


" augroup completeopts
" 	autocmd BufEnter * lua require'completion'.on_attach()
" 	set completeopt=menuone,noinsert,noselect
" 	set shortmess+=c

" 	" make enter select completion
" 	inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" 	let g:completion_chain_complete_list = {
" 	    \ 'default': [
" 	    \    {'complete_items': ['tabnine', 'lsp', 'ts', 'buffers', 'snippet']},
" 	    \    {'mode': '<c-n>'}
" 	    \]
" 	\}
" 	" show matches in original order
" 	let g:completion_matching_strategy_list = []

" 	let g:completion_enable_auto_popup = 1
" 	let g:completion_tabnine_priority = 1000
" 	let g:completion_timer_cycle = 80
" 	let g:completion_enable_auto_signature = 1
" 	let g:completion_trigger_keyword_length = 2
" 	let g:completion_tabnine_max_num_results=7
" 	let g:completion_tabnine_sort_by_details=1
" 	let g:completion_tabnine_max_lines=1000
" augroup end


set guicursor=

" for vim-surround:
" when surrounding with 'e', ask for a wrapper
let g:surround_101 = "\1wrapper:\1(\r)"

" dont paste toggle
set pastetoggle=

" config for vim-signify
let g:signify_vcs_list = [ 'git', 'hg' ] 


augroup tabularShorts
autocmd!
	nnoremap <Leader>t= :Tabularize /=<CR>
	vnoremap <Leader>t= :Tabularize /=<CR>
	nnoremap <Leader>t: :Tabularize /:\zs<CR>
	vnoremap <Leader>t: :Tabularize /:\zs<CR>
	nnoremap <Leader>t, :Tabularize /,\zs<CR>
	vnoremap <Leader>t, :Tabularize /,\zs<CR>
	nnoremap <Leader>t> :Tabularize /=>\zs<CR>
	vnoremap <Leader>t> :Tabularize /=>\zs<CR>
augroup end

" indentguide
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_color_change_percent = 20

" for vim-slash
" noremap <plug>(slash-after) zz
"


" disable csv
let g:polyglot_disabled = ['csv', 'latex']

" syntax ranges:
augroup syntax_ranges
	autocmd!
	autocmd FileType html,js,javascript call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'SpecialComment')
	autocmd FileType html,js,javascript call SyntaxRange#Include('<script>', '</script>', 'javascript', 'SpecialComment')
augroup end

lua << EOF

local on_attach_vim = function(client)
  -- require'completion'.on_attach(client)
end

local lspconfig = require'lspconfig'
require'lspconfig'.jedi_language_server.setup{on_attach=on_attach_vim}
require'lspconfig'.jsonls.setup{on_attach=on_attach_vim}
require'lspconfig'.vimls.setup{on_attach=on_attach_vim}

lspconfig.bashls.setup{
	on_attach = on_attach_vim;
	settings = {
		bashls = {
			    filetypes = { "sh", "zsh" };
		};
	};
};

lspconfig.html.setup{
	on_attach = on_attach_vim;
	settings = {
		html = {
			filetypes = { "html", "css" };
		};
	};
};

-- LspInstall sqlls
require'lspconfig'.sqlls.setup{
	on_attach = on_attach_vim;
};

-- treesitter

require'nvim-treesitter.configs'.setup {
	indent = {
   	 	enable = true
   	 },
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = { "rust" },        -- list of language that will be disabled
      custom_captures = {               -- mapping of user defined captures to highlight groups
        -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
      },
    },
    incremental_selection = {
      enable = true,
      disable = { "lua" },
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm",       -- decrement to the previous node
      }
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = false
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "gt"          -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",      -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD"      -- mapping to list all definitions in current file
        }
      }
    },
    textobjects = {
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      keymaps = {
	      -- You can use the capture groups defined in textobjects.scm
	      ["af"] = "@function.outer",
	      ["if"] = "@function.inner",
	      ["ac"] = "@class.outer",
	      ["ic"] = "@class.inner",

	      -- Or you can define your own textobjects like this
	      ["iF"] = {
		      python = "(function_definition) @function",
		      cpp = "(function_definition) @function",
		      c = "(function_definition) @function",
		      java = "(method_declaration) @function",
	      },
		},
	},
	swap = {
		enable = true,
		swap_next = {
			["<leader>gs"] = "@parameter.inner",
		},
		swap_previous = {
			["<leader>gS"] = "@parameter.inner",
		},
	},
	move = {
	      enable = true,
	      goto_next_start = {
		["]m"] = "@function.outer",
		["]]"] = "@class.outer",
	      },
	      goto_next_end = {
		["]M"] = "@function.outer",
		["]["] = "@class.outer",
	      },
	      goto_previous_start = {
		["[m"] = "@function.outer",
		["[["] = "@class.outer",
	      },
	      goto_previous_end = {
		["[M"] = "@function.outer",
		["[]"] = "@class.outer",
	      },
	},
    ensure_installed = "all"
    }
}

-- lsp_utils
vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

vim.g.lsp_utils_location_opts = {
	height = 24,
	mode = 'editor',
	preview = {
		title = 'Location Preview',
		border = true,
		coloring = true,
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k'
		}
	}
}
vim.g.lsp_utils_symbols_opts = {
	height = 0,
	mode = 'editor',
	preview = {
		title = 'Symbol Preview',
		border = true,
		coloring = true,
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k'
		}
	}
}

-- iron conf
local iron = require("iron")

iron.core.set_config{
	preferred = {
		python = "ipython",
	},
	memory_management = 'singleton',
}

EOF

function! CleverKey(key)
	if col('.') <= 0
		return a:key
	endif
	if col('.') > strlen(getline('.'))
		return a:key
	endif
	if nr2char(strgetchar(getline('.'), col('.') - 1)) == a:key
		return "\<Right>"
	else
		return a:key
	endif
endfunction
inoremap <expr> ) CleverKey(")")
inoremap <expr> ' CleverKey("'")
inoremap <expr> " CleverKey('"')
inoremap <expr> ] CleverKey(']')
inoremap <expr> , CleverKey(',')


" git fugitive commands
command -nargs=* Glg Git --paginate lg <args>
