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
set guifont=Fira\ Code:h14
set noswapfile

" set t_8f=^[[38;2;%lu;%lu;%lum
" set t_8b=^[[48;2;%lu;%lu;%lum

let mapleader=","

" do this b4 loading plugins
let g:kommentary_create_default_mappings=0

autocmd BufWritePost plugins.lua PackerCompile

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
set textwidth=80	" set text width to 80 chars.
set tabpagemax=30       "how many tabs to allow at max
set hlsearch
set viminfo='50,\"100,:50,%,n~/.viminfo
set laststatus=2
set encoding=utf-8
set so=5 "cursor cant get closer than 5 lines to end of screen
set spelllang=en
set hidden
set modeline
set tagstack

" do not show more than 20 completion items
set pumheight=20

" default yank to clip
set clipboard=unnamedplus

" this controls saving swap and highlighting var under cursor
set updatetime=100

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
  au! FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup end

augroup ftypePython
	autocmd!
	au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 number
	au FileType python setlocal number
	" autocmd BufWritePre *.py :call TrimWhitespace()
	autocmd FileType python set textwidth=120	" set text width to 70 chars.
	autocmd FileType python nnoremap <Leader>fs :FToggle<Cr>
	autocmd FileType python command! -range=% YAPF <line1>,<line2>call yapf#YAPF()
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
	autocmd BufEnter *.html set ft=html
	autocmd BufEnter *.html syntax sync fromstart
	" autocmd BufEnter *.html set ft=html.javascript
	autocmd BufEnter *.html set textwidth=10000
	au FileType html setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 number

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
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'angr'

"gundo
nnoremap <F5> :GundoToggle<CR>

" fzf config
nnoremap <Leader>pb <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <Leader>pp <cmd>lua require('fzf-lua').files()<CR>
nnoremap <Leader>pt <cmd>lua require('fzf-lua').loclist()<CR>
nnoremap <Leader>pg <cmd>lua require('fzf-lua').grep()<CR>

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

"open up .vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<cr>G
"source up .vimrc
nnoremap <leader>vs :source $MYVIMRC<cr>

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

function! ReverseJ(text)
	let l:text = substitute(a:text, "(", "(\n", "")
	let l:text = substitute(l:text, ",", ",\n", "g")
	let l:text = substitute(l:text, ")", "\n)", "g")
	return l:text
endfunction

call TextTransform#MakeMappings('', 'gj', 'ReverseJ')


let g:nvcode_termcolors=256
colorscheme zephyr
highlight Normal guibg=black guifg=wheat
highlight MatchParen guibg=lightblue
"for highlight text
highlight Search guibg=red

set background=dark

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

" syntax ranges:
augroup syntax_ranges
	autocmd!
	autocmd FileType html.javascript,html,js,javascript call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'SpecialComment')
	autocmd FileType html.javascript,html,js,javascript call SyntaxRange#Include('<script>', '</script>', 'javascript', 'SpecialComment')
augroup end

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

" let g:compe.source.tabnine = {}
" let g:compe.source.tabnine.max_line = 1000
" let g:compe.source.tabnine.max_num_results = 10
" let g:compe.source.tabnine.priority = 5000
" let g:compe.source.tabnine.show_prediction_strength = v:true
" let g:compe.source.tabnine.sort = v:false
" let g:compe.source.tabnine.ignore_pattern = '[%s%c]'


inoremap jj <esc>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;


" this is in misc.lua
autocmd FileType python nnoremap <silent> <C-i> :.luado add_ignore_type(line, linenr - 1)<cr>
autocmd FileType python vnoremap <silent> <C-i> :luado add_ignore_type(line, linenr - 1)<cr>

" highlight whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='red'

" doge
let g:doge_comment_jump_modes = ['n', 's']

"iron
let g:iron_map_defaults = 0
let g:iron_map_extended = 0

" nnoremap <leader>c <Plug>(iron-send-motion)
vnoremap <leader>c :lua require('iron').core.visual_send()<cr>

" highligh on yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=350, on_visual=true}


lua require('misc')
lua require('plugins')
lua require('lsp_conf')
lua require('ts_conf')


" wilder setup
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
      \       'dir_command': ['fd', '-td'],
      \       'filters': ['cpsm_filter'],
      \       'cache_timestamp': {-> 1},
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#python_cpsm_filter(),
      \       'set_pcre2_pattern': 0,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern({
      \         'start_at_boundary': 0,
      \       }),
      \     }),
      \   ),
      \ ])

highlight WilderMatch guifg=wheat gui=bold gui=underline
let s:highlighters = [
      \ wilder#pcre2_highlighter(),
      \ wilder#lua_fzy_highlighter(),
      \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'left': [
      \     wilder#popupmenu_devicons(),
      \   ],
      \   'right': [
      \     ' ',
      \     wilder#popupmenu_scrollbar(),
      \   ],
      \   'highlights': {
      \      'accent': 'WilderMatch',
      \   },
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'highlights': {
      \      'accent': 'WilderMatch',
      \   },
      \ }),
      \ }))


"magma setup
let g:magma_save_path = stdpath("data") .. "/magma/"
function! MyMagmaInit()
	PackerLoad 'magma-nvim'
	setlocal filetype=python
	set syntax=python
	let l:mangled_fname = expand('%:p') .. '.json'
	let l:mangled_fname = substitute(l:mangled_fname, '%', '%%', 'g')
	let l:mangled_fname = substitute(l:mangled_fname, '/', '%', 'g')
	let l:save_file = g:magma_save_path .. l:mangled_fname
	if filereadable(l:save_file)
		MagmaLoad
	else
		MagmaInit python3
	endif
endfunction

augroup magma
  au! BufRead,BufNewFile *.jupyter call MyMagmaInit()
  au! BufWrite *.jupyter MagmaSave
augroup end

nnoremap <expr><silent> <Leader>r  nvim_exec('MagmaEvaluateOperator', v:true)
nnoremap <silent>       <Leader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <Leader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent> <Leader>ro :MagmaShowOutput<CR>
nnoremap <silent> <Leader>re :MagmaReevaluateCell<CR>
nnoremap <silent> <Leader>rd :MagmaDelete<CR>
nnoremap <silent> <Leader>ri :MagmaInit<CR>
nnoremap <silent> <Leader>rs :MagmaSave<CR>
nnoremap <silent> <Leader>rl :MagmaLoad<CR>

let g:magma_automatically_open_output = v:true
" let g:magma_image_provider = 'hologram'
