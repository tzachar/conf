 "set terminal for 256 colors
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

" auto install vim-plug and plugs
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" color scheme
" Plug 'joshdick/onedark.vim'
" Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'glepnir/zephyr-nvim', {'branch': 'main'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Plug 'deoplete-plugins/deoplete-zsh'
" Plug 'Shougo/deoplete-lsp'
" Plug 'Shougo/neco-vim'
" Plug 'fszymanski/deoplete-emoji'

Plug 'hrsh7th/nvim-compe'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' } 

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Plug 'nvim-lua/completion-nvim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }
" Plug 'nvim-treesitter/completion-treesitter'
" Plug 'steelsojka/completion-buffers'



Plug 'sjl/gundo.vim'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
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
" Plug 'flazz/vim-colorschemes'
" Plug 'felixhummel/setcolors.vim'

" show changes in vcs
Plug 'mhinz/vim-signify'

" python formatter
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" Plug 'sbdchd/neoformat'

" Plug 'tzachar/vim-fsub', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent'

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
" Plug 'axelf4/vim-strip-trailing-whitespace'
Plug 'ntpeters/vim-better-whitespace'

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'Iron-E/nvim-highlite'

"lsp config
" Plug 'RishabhRD/popfix', { 'do' : 'make' }
" Plug 'RishabhRD/nvim-lsputils'

Plug 'ojroques/nvim-lspfuzzy', {'branch': 'main'}

" git
Plug 'tpope/vim-fugitive'

" iron, repr integration
Plug 'hkupty/iron.nvim'

" update language servers
Plug 'alexaandru/nvim-lspupdate'

" auto add delimiters
" Plug 'cohama/lexima.vim'

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
set updatetime=100

" deoplete:
" let g:deoplete#enable_at_startup = 1
" let g:LanguageClient_hasSnippetsSupport = 0
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ deoplete#manual_complete()

" call deoplete#custom#option('auto_complete_delay', 100)
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" completion-nvim
" autocmd BufEnter * lua require'completion'.on_attach()
" " Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" let g:completion_trigger_keyword_length = 1
" let g:completion_trigger_on_delete = 1
" let g:completion_timer_cycle = 200
" let g:completion_enable_auto_signature = 0


" set tex flavor:
let g:tex_flavor = 'latex'

"search for tags first in the file dir, then current dir, then boost:
set tags=./tags,tags,/usr/local/boost/tags,/home/tzachar/.vim/tags/stl_tags

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" set filetypes
filetype on
" filetype plugin indent on

syntax on		" Default to no syntax highlightning


augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
  au! BufRead,BufNewFile *.pp setfiletype puppet
  au! FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
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

" augroup popups
" 	au!
" 	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" 	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" augroup end

nnoremap <C-N> :cn<CR>
nnoremap <C-@><C-N> :cN<CR>


"for Switch:
let g:switch_mapping = "-"

" airline
let g:airline#extensions#nvimlsp#enabled = 0
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
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let opts = {
        \ 'relative': 'cursor',
  	\ 'col': 0,
	\ 'row': 1,
        \ 'width': 120,
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
let g:nvcode_termcolors=256
" colorscheme onedark
colorscheme zephyr
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

local lspconfig = require'lspconfig'
local nvim_lsp = require('lspconfig')

local on_attach = function(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "jedi_language_server", "jsonls", "vimls", "bashls", "html", "sqlls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

lspconfig.bashls.setup{
	settings = {
		bashls = {
			    filetypes = { "sh", "zsh" };
		};
	};
};

lspconfig.html.setup{
	settings = {
		html = {
			filetypes = { "html", "css" };
		};
	};
};

-- treesitter
require'nvim-treesitter.configs'.setup {
	indent = {
   	 	enable = false
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

-- lsp fzf integration
require('lspfuzzy').setup {}


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

" function! CleverKey(key)
" 	if col('.') <= 0
" 		return a:key
" 	endif
" 	if col('.') > strlen(getline('.'))
" 		return a:key
" 	endif
" 	if nr2char(strgetchar(getline('.'), col('.') - 1)) == a:key
" 		return "\<Right>"
" 	else
" 		return a:key
" 	endif
" endfunction
" inoremap <expr> ) CleverKey(")")
" inoremap <expr> ' CleverKey("'")
" inoremap <expr> " CleverKey('"')
" inoremap <expr> ] CleverKey(']')
" inoremap <expr> , CleverKey(',')


function! Tsreload()
	write
	edit
	TSBufEnable highlight
endfunction
command TSReload :call Tsreload()

" git fugitive commands
command -nargs=* Glg Git --paginate lg <args>

" vim sneak
let g:sneak#s_next=1

" semshi
let g:semshi#mark_selected_nodes=0

" compe
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 100
let g:compe.source_timeout = 400
let g:compe.incomplete_delay = 500
let g:compe.allow_prefix_unmatch = v:false

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:false
" let g:compe.source.tabnine = v:true
let g:compe.source.tabnine = {}
let g:compe.source.tabnine.max_line = 1000
let g:compe.source.tabnine.max_num_results = 6
let g:compe.source.tabnine.priority = 5000

" let g:lexima_no_default_rules = v:true
" call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
lua << EOF

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--  return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
 -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
 --   return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


" highlight whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='red'
