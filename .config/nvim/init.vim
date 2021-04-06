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

" set t_8f=^[[38;2;%lu;%lu;%lum
" set t_8b=^[[48;2;%lu;%lu;%lum

let mapleader=","

lua require('misc')
lua require('plugins')
lua require('lsp_conf')
lua require('ts_conf')

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

" do not show more than 20 completion items
set pumheight=20

" default yank to clip
set clipboard+=unnamed

" this controls saving swap and highlighting var under cursor
set updatetime=100

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
	autocmd BufEnter *.html syntax sync fromstart
	autocmd BufEnter *.html set ft=html.javascript
	autocmd BufEnter *.html set textwidth=10000

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
let g:compe.allow_prefix_unmatch = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.emoji = v:true
let g:compe.source.snippets_nvim = v:false
" let g:compe.source.tabnine = v:false
" let g:compe.source.tabnine = v:true
let g:compe.source.tabnine = {}
let g:compe.source.tabnine.max_line = 1000
let g:compe.source.tabnine.max_num_results = 10
let g:compe.source.tabnine.priority = 5000
let g:compe.source.tabnine.show_prediction_strength = v:true
let g:compe.source.tabnine.sort = v:true



" let g:lexima_no_default_rules = v:true
" call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <CR>      compe#confirm('<CR>', { 'replace': v:true })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" inoremap <silent><expr> <C-l>     compe#confirm({ 'replace': v:true })

" inoremap <silent><expr> jj 	  pumvisible() ? compe#confirm('<CR>') : '<esc>'


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
