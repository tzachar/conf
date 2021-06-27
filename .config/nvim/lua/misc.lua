local vim = vim
-- iron conf
require('nrpattern').setup()
local iron = require("iron")

iron.core.set_config{
	preferred = {
		python = "ipython",
	},
	memory_management = 'singleton',
}


function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- this is for compe

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


-- should be called with luado
function add_ignore_type(line, linenr)
	local ignore_decl = ' # type: ignore'
	if #(vim.lsp.diagnostic.get_line_diagnostics(0, linenr)) > 0 then
		vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, {ignore_decl})
	elseif string.sub(line, -15, -1) == ignore_decl then
		vim.api.nvim_buf_set_text(0, linenr, #line - #ignore_decl, linenr, #line, {})
	end
end


-- zephyr override
vim.g.zephyr = {
	override = {
		TSVariable = {fg='wheat'};
	};
}

local kconfig = require('kommentary.config')
local kommentary = require('kommentary.kommentary')

function yank_and_comment(...)
	local args = {...}
	local start_line = args[1]
	local end_line = args[2]
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	vim.api.nvim_command(tostring(start_line) .. ',' .. tostring(end_line) .. 'y')
	kommentary.toggle_comment_range(start_line, end_line, kconfig.get_modes().normal)
	vim.fn.feedkeys('<ctrl-c>')
end

kconfig.add_keymap("n", "kommentary_yank_and_comment_line", kconfig.context.line, {}, "yank_and_comment")
kconfig.add_keymap("v", "kommentary_yank_and_comment_visual", kconfig.context.visual, {}, "yank_and_comment")
kconfig.add_keymap("n", "kommentary_yank_and_comment_motion", kconfig.context.init, {expr = true}, "yank_and_comment")
-- Set up a regular keymapping to the new <Plug> mapping
vim.api.nvim_set_keymap('n', 'gcyy', '<Plug>kommentary_yank_and_comment_line', { silent = true })
vim.api.nvim_set_keymap('n', 'gcy', '<Plug>kommentary_yank_and_comment_motion', { silent = true })
vim.api.nvim_set_keymap('v', 'gcy', '<Plug>kommentary_yank_and_comment_visual', { silent = true })

vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default<esc>", {})


require'nvim-treesitter.configs'.setup {
	rainbow = {
		enable = true;
		extended_mode = true;
		max_file_lines = 800;
	}
}

require'lightspeed'.setup {
	jump_to_first_match = true,
	jump_on_partial_input_safety_timeout = 400,
	highlight_unique_chars = false,
	grey_out_search_area = true,
	match_only_the_start_of_same_char_seqs = true,
	limit_ft_matches = 5,
	full_inclusive_prefix_key = '<c-x>',
}
