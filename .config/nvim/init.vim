 "set terminal for 256 colors
" if has('nvim') && match($TERM, "screen")!=-1
" 	set term=xterm
" endif

" disable python2
let g:loaded_python_provider = 1
let g:python_host_prog = ""
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
set guicursor=
" dont paste toggle
set pastetoggle=


" do not show more than 20 completion items
set pumheight=20

set completeopt=menu,menuone,noselect

" default yank to clip
set clipboard=unnamedplus

" this controls saving swap and highlighting var under cursor
set updatetime=100

" how much to wait for key sequence to complete
set timeoutlen=500

" set tex flavor:
let g:tex_flavor = 'latex'

"search for tags first in the file dir, then current dir, then boost:
set tags=./tags,tags,/usr/local/boost/tags,/home/tzachar/.vim/tags/stl_tags

" set filetypes
filetype on
filetype plugin indent on

syntax on		" Default to no syntax highlightning


augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
  au! BufRead,BufNewFile *.pp setfiletype puppet
  au! FileType yaml,lua setlocal ts=2 sts=2 sw=2 expandtab number
augroup end

augroup ftypePython
	autocmd!
	au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 number
	au FileType python setlocal number
	" autocmd BufWritePre *.py :call TrimWhitespace()
	autocmd FileType python set textwidth=120	" set text width to 70 chars.
	autocmd FileType python nnoremap <Leader>fs :FToggle<Cr>
	autocmd FileType python command! -range=% YAPF <line1>,<line2>call yapf#YAPF()
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

	autocmd BufEnter *.heb.tex setlocal spell spelllang=he
	autocmd BufEnter *.heb.tex setlocal rightleft


augroup end

" function! UpdateTimeStamp()
" 	let l:winview = winsaveview()
" 	%s/LAST_CHANGE "\zs[^"]*/\= strftime("%c")/e
" 	%s/LAST_CHANGE_DATE "\zs[^"]*/\= strftime("%Y%m%d")/e
" 	call winrestview(l:winview)
" endfunction

" augroup TimeStamp
" 	au!
" 	au! BufWritePre,FileWritePre,FileAppendPre *.cpp,*.c,*.py,*.h,*.hpp :call UpdateTimeStamp()
" augroup END

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

"buffergatror oftions
let g:buffergator_viewport_split_policy="B"
let g:buffergator_split_size="10"

"spelling highlight
hi SpellBad term=reverse ctermfg=white ctermbg=darkred guifg=#ffffff guibg=#7f0000 gui=underline
hi SpellCap guifg=#ffffff guibg=#7f007f
hi SpellRare guifg=#ffffff guibg=#00007f gui=underline
hi SpellLocal term=reverse ctermfg=black ctermbg=darkgreen guifg=#ffffff guibg=#7f0000 gui=underline

" cmp highlighting is done by colorscheme
" " cmp items highlighting" gray
" highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" " blue
" highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
" highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" " light blue
" highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
" highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
" highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" " pink
" highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
" highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" " front
" highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
" highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
" highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

"for Switch:
let g:switch_mapping = "-"


"FSwitch
"Switch to the file and load it into the current window >
augroup mycppfiles
	au!
	au BufEnter *.h,*.hpp let b:fswitchdst  = 'cpp,cc,C'
	au BufEnter *.h,*.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
	au BufEnter *.c,*.cpp let b:fswitchdst = 'h,hpp'
	au BufEnter *.c,*.cpp let b:fswitchlocs = 'reg:|src|include/**|'
	au BufEnter *.c,*.cpp abbrev autp auto
	au FileType c,cpp nnoremap <silent> <Leader>of :FSHere<cr>
	au FileType c,cpp nnoremap <silent> <Leader>oo :FSHere<cr>
	au FileType c,cpp nnoremap <silent> <Leader>ol :FSRight<cr>
augroup END

"folding highlight
hi Folded term=standout ctermfg=LightBlue ctermbg=DarkGrey

"localvimrc
let g:localvimrc_sandbox=0

"add a ; at the end of the line
function! ToggleEndChar(charToMatch)
	let l:winview = winsaveview()
	s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
	nohlsearch
	call winrestview(l:winview)
endfunction
nnoremap <Leader>; :call ToggleEndChar(';')<CR>

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

" augroup replacegJ
" 	fun! JoinSpaceless()
" 		if getline('.')[-1:-1] == '(' || getline('.')[-1:-1] == '['
" 			execute 'normal! gJ'
" 			" Character under cursor is whitespace?
" 			if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
" 				" Then remove it!
" 				execute 'normal dw'
" 			endif
" 		else
" 			execute 'normal! J'
" 		endif
" 	endfun

" 	" Map it to a key
" 	nnoremap J :call JoinSpaceless()<CR>
" augroup end

" tag closing
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" vimtex
let g:vimtex_compiler_enabled = 0

" for vim-surround:
" when surrounding with 'e', ask for a wrapper
" let g:surround_101 = "\1wrapper:\1(\r)"

" config for vim-signify
" let g:signify_vcs_list = [ 'git', 'hg' ]

" gitgutter config
let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 1


" indentguide
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_color_change_percent = 20

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

" highlight whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='red'

" doge
let g:doge_comment_jump_modes = ['n', 's']

"iron
let g:iron_map_defaults = 0
let g:iron_map_extended = 0

" highligh on yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=350, on_visual=true}

lua _G.use_cachepack = true
lua require('impatient')
lua require('misc')
lua require('packer_compiled')
lua require('plugins')
lua require('lsp_conf')
lua require('ts_conf')
lua require('keymaps')
lua require('cmp_setup')


"magma setup
let g:magma_save_path = stdpath("data") .. "/magma/"
function! MyMagmaInit()
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

highligh MagmaCellBG guibg=#222222
let g:magma_automatically_open_output = v:true
let g:magma_image_provider = 'kitty'
let g:magma_show_mimetype_debug = v:true
let g:magma_cell_highlight_group = 'MagmaCellBG'


highlight Normal guibg=black guifg=wheat
highlight MatchParen guibg=lightblue
"for highlight text
highlight Search guibg=red
" set background=dark

" vsnip
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" configuration for splitjoin
let g:splitjoin_align = 1
let g:splitjoin_curly_brace_padding = 1
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_split_mapping = '<leader>s'
let g:splitjoin_join_mapping  = '<leader>j'
