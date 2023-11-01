vim.loader.enable()
vim.g.loaded_python_provider = 1
vim.g.python_host_prog = ''
vim.g.python3_host_prog = vim.fn.environ()['HOME'] .. '/.pyenv/shims/python3'

vim.g.mapleader = ','

-- vim.opt.t_ku = "[A"
-- vim.opt.t_kd = "[B"
-- vim.opt.t_kl = "[D"
-- vim.opt.t_kr = "[C"

if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end
vim.g.nvcode_termcolors = 256

if vim.fn.has('nvim') then
  vim.fn.environ()['NVIM_TUI_ENABLE_TRUE_COLOR'] = 1
end
vim.opt.guifont = 'Fira Code:h14'
vim.opt.swapfile = false

vim.g.kommentary_create_default_mappings = 0

vim.opt.compatible = false -- Use Vim defaults (much better!)
vim.opt.showcmd = true -- Show (partial) command in status line.
vim.opt.mouse = ''
vim.opt.showmatch = true -- Show matching brackets.
vim.opt.ruler = true -- Show the line and column numbers of the cursor
vim.opt.ignorecase = true -- Do case insensitive matching
vim.opt.incsearch = true -- Incremental search
vim.opt.autowrite = true -- Automatically save before commands like :next and :make
vim.opt.history = 10000
vim.opt.backspace = 'indent,eol,start' -- allow backspacing over everything in insert mode
vim.opt.smartindent = true
vim.opt.autoindent = true -- always set autoindenting on
vim.opt.backup = false -- do not keep a backup file
vim.opt.number = true
vim.opt.textwidth = 80 -- set text width to 80 chars.
vim.opt.tabpagemax = 30 --how many tabs to allow at max
vim.opt.hlsearch = true
-- vim.opt.viminfo = '50,"100,:50,%,n~/.viminfo'
vim.opt.laststatus = 2
vim.opt.encoding = 'utf-8'
vim.opt.so = 5 --cursor cant get closer than 5 lines to end of screen
vim.opt.spelllang = 'en'
vim.opt.hidden = true
vim.opt.modeline = true
vim.opt.tagstack = true
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- always show the sign column. prevent smoothcursor from jumping the window
vim.opt.signcolumn = 'yes:1'

-- do not show more than 20 completion items
vim.opt.pumheight = 20

vim.opt.completeopt = 'menu,menuone,noselect'

-- default yank to clip
vim.opt.clipboard = 'unnamedplus'

-- this controls saving swap and highlighting var under cursor
vim.opt.updatetime = 100

-- how much to wait for key sequence to complete
vim.opt.timeoutlen = 500

-- set tex flavor:
vim.g.tex_flavor = 'latex'

--search for tags first in the file dir, then current dir, then boost:
vim.opt.tags = './tags,tags,/usr/local/boost/tags,/home/tzachar/.vim/tags/stl_tags'

vim.opt.splitkeep = 'screen'

vim.opt.diffopt = vim.opt.diffopt + 'linematch:60'

vim.opt.shada = [[!,'100,<50,s10,h,%]]

-- set filetypes
-- filetype on
-- filetype plugin indent on

-- syntax on		" Default to no syntax highlightning

-- augroup ftypeOptions
-- 	autocmd!
--
-- 	autocmd BufEnter *.tex setlocal makeprg=~/bin/latexmake.sh
-- 	autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>l :execute "!~tzachar/bin/pdflatexmake.sh " . expand("%:r") <cr><cr>
-- 	autocmd BufEnter *.tex nnoremap <buffer> <silent> <Leader>x :execute "!~tzachar/bin/latexmake.sh " . line("."). " " . expand("%:r")<cr><cr>
-- 	autocmd BufEnter *.tex setlocal spell spelllang=en
-- 	autocmd BufEnter *.tex inoremap <buffer> [[ \begin{
-- 	autocmd BufEnter *.tex inoremap <buffer> \i \item
-- 	autocmd BufEnter *.heb.tex setlocal spell spelllang=he
-- 	autocmd BufEnter *.heb.tex setlocal rightleft
-- 	" autocmd BufEnter *.tex nnoremap <buffer> =  <ESC>:call FormatLatexPar(0)<CR>
--
-- 	"js
-- 	autocmd BufEnter *.html set ft=html
-- 	autocmd BufEnter *.html syntax sync fromstart
-- augroup end

-- function! UpdateTimeStamp()
-- 	let l:winview = winsaveview()
-- 	%s/LAST_CHANGE "\zs[^"]*/\= strftime("%c")/e
-- 	%s/LAST_CHANGE_DATE "\zs[^"]*/\= strftime("%Y%m%d")/e
-- 	call winrestview(l:winview)
-- endfunction

-- augroup TimeStamp
-- 	au!
-- 	au! BufWritePre,FileWritePre,FileAppendPre *.cpp,*.c,*.py,*.h,*.hpp :call UpdateTimeStamp()
-- augroup END

-- vim -b : edit binary using xxd-format!

-- augroup Binary
-- 	au!
-- 	au BufReadPre  *.bin let &bin=1
-- 	au BufReadPost *.bin if &bin | %!xxd
-- 	au BufReadPost *.bin set ft=xxd | endif
-- 	au BufWritePre *.bin if &bin | %!xxd -r
-- 	au BufWritePre *.bin endif
-- 	au BufWritePost *.bin if &bin | %!xxd
-- 	au BufWritePost *.bin set nomod | endif
-- augroup END
--
--buffergatror oftions
-- vim.g.buffergator_viewport_split_policy="B"
-- vim.g.buffergator_split_size="10"

--spelling highlight
vim.api.nvim_set_hl(0, 'SpellBad', {
  reverse = true,
  ctermfg = 'white',
  ctermbg = 'darkred',
  fg = '#ffffff',
  bg = '#7f0000',
  underline = true,
})
vim.api.nvim_set_hl(0, 'SpellCap', {
  fg = '#ffffff',
  bg = '#7f007f',
})
vim.api.nvim_set_hl(0, 'SpellRare', {
  fg = '#ffffff',
  bg = '#00007f',
  underline = true,
})
vim.api.nvim_set_hl(0, 'SpellLocal', {
  reverse = true,
  ctermfg = 'black',
  ctermbg = 'darkgreen',
  fg = '#ffffff',
  bg = '#7f0000',
  underline = true,
})

--FSwitch
--Switch to the file and load it into the current window >
-- augroup mycppfiles
-- 	au!
-- 	au BufEnter *.h,*.hpp let b:fswitchdst  = 'cpp,cc,C'
-- 	au BufEnter *.h,*.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
-- 	au BufEnter *.c,*.cpp let b:fswitchdst = 'h,hpp'
-- 	au BufEnter *.c,*.cpp let b:fswitchlocs = 'reg:|src|include/**|'
-- 	au BufEnter *.c,*.cpp abbrev autp auto
-- 	au FileType c,cpp nnoremap <silent> <Leader>of :FSHere<cr>
-- 	au FileType c,cpp nnoremap <silent> <Leader>oo :FSHere<cr>
-- 	au FileType c,cpp nnoremap <silent> <Leader>ol :FSRight<cr>
-- augroup END

--folding highlight
vim.api.nvim_set_hl(0, 'Folded', {
  standout = true,
  ctermfg = 'LightBlue',
  ctermbg = 'DarkGrey',
})

--add a ; at the end of the line
vim.cmd([[
function! ToggleEndChar(charToMatch)
	let l:winview = winsaveview()
	s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
	nohlsearch
	call winrestview(l:winview)
endfunction
]])
vim.keymap.set('n', '<Leader>;', ":call ToggleEndChar(';')<CR>", {})

-- The Silver Searcher
if vim.fn.executable('ag') then
  -- Use ag over grep
  vim.o.grepprg = 'ag --nogroup --nocolor'
end

-- function! PerlFormat(str)
--   let out = system('perl -e "use Text::Autoformat; autoformat {break=>break_wrap, all=>1, left=>1, right=>80};"', a:str)
--   return out
-- endfunction
-- call TextTransform#MakeMappings('', '<Leader>pf', 'PerlFormat')

--for dbext
-- vim.g.dbext_default_profile_Vault = 'type=SQLITE:dbname=/home/' . $USER . '/work/vault/db/vault.sqlite'
-- vim.g.dbext_default_SQLITE_cmd_header=".mode list\n.headers ON\n"
-- vim.g.dbext_default_DBI_max_rows = 0
-- augroup project_vault
-- 	au!
--
-- 	fun! SetupDbext()
-- 		DBSetOption profile=Vault
-- 	endfun
--
-- 	" Automatically choose the correct dbext profile
-- 	autocmd BufRead */vault/db/*.sql DBSetOption profile=Vault
-- 	" autocmd BufRead */vault/db/*.sql SetupDbext()
--
-- 	function! DBextPostResult(db_type, buf_nr)
-- 		if a:db_type == 'SQLITE' && line('$') >= 2
-- 			execute ':silent 2,$! showtable -d\| -t -title=1'
-- 		endif
-- 	endfunction
-- augroup end
--

vim.cmd([[
augroup replacegJ
	fun! JoinSpaceless()
		if getline('.')[-1:-1] == '(' || getline('.')[-1:-1] == '[' || getline('.')[-1:-1] == '{'
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
]])

-- tag closing
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml'

-- vimtex
vim.g.vimtex_compiler_enabled = 0

-- indentguide
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_auto_colors = 1
vim.g.indent_guides_color_change_percent = 20

-- function! CleverKey(key)
-- 	if col('.') <= 0
-- 		return a:key
-- 	endif
-- 	if col('.') > strlen(getline('.'))
-- 		return a:key
-- 	endif
-- 	if nr2char(strgetchar(getline('.'), col('.') - 1)) == a:key
-- 		return "\<Right>"
-- 	else
-- 		return a:key
-- 	endif
-- endfunction
-- inoremap <expr> ) CleverKey(")")
-- inoremap <expr> ' CleverKey("'")
-- inoremap <expr> " CleverKey('"')
-- inoremap <expr> ] CleverKey(']')
-- inoremap <expr> , CleverKey(',')

vim.api.nvim_create_user_command('TSReload', function()
  vim.cmd([[
      write
      edit
      TSBufEnable highlight
  ]])
end, {})

-- highlight whitespace
vim.g.better_whitespace_ctermcolor = 'red'
vim.g.better_whitespace_guicolor = 'red'

-- doge
vim.g.doge_comment_jump_modes = { 'n', 's' }

--iron
vim.g.iron_map_defaults = 0
vim.g.iron_map_extended = 0

vim.api.nvim_set_hl(0, 'MatchParen', {
  ctermbg = 'darkblue',
  bg = '#a0a0a0',
  italic = true,
})
vim.api.nvim_set_hl(0, 'Search', {
  bg = 'red',
})

-- vsnip
-- vim.cmd([[
-- " Expand
-- imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
-- smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
--
-- " Expand or jump
-- imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
-- smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
--
-- " Jump forward or backward
-- imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
-- smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
-- ]])

-- matchup
vim.g.matchup_matchparen_deferred = 5

-- ai
vim.g.ai_no_mappings = 1

function dump(...) ---@diagnostic disable-line
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('plugins')
require('misc')

vim.api.nvim_set_hl(0, 'Normal', {
  fg = 'wheat',
  bg = 'black',
})
