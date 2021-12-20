local vim = vim
-- iron conf
require('nrpattern').setup()
local iron = require("iron")

iron.core.set_config{
	preferred = {
		python = "ipython",
	},
	memory_management = 'singleton',
	highlight_last = false,
}

function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- should be called with luado
function add_ignore_type(line, linenr)
	local ignore_decl = ' # type: ignore'
	if #(vim.lsp.diagnostic.get_line_diagnostics(0, linenr)) > 0 then
		vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, {ignore_decl})
	elseif string.sub(line, -15, -1) == ignore_decl then
		vim.api.nvim_buf_set_text(0, linenr, #line - #ignore_decl, linenr, #line, {})
	end
end
local nest = require('nest')
nest.applyKeymaps({
	{ mode = 'n', {
		{ '<C-i>', '<cmd>.luado add_ignore_type(line, linenr - 1)<cr>', options = { silent = true } },
	}},
	{ mode = 'v', {
		{ '<C-i>', '<cmd>luado add_ignore_type(line, linenr - 1)<cr>', options = { silent = true } },
	}},
})


local kconfig = require('kommentary.config')
local kommentary = require('kommentary.kommentary')

local function yank_and_comment(...)
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

kconfig.add_keymap("n", "kommentary_yank_and_comment_line", kconfig.context.line, {expr = true}, yank_and_comment)
kconfig.add_keymap("v", "kommentary_yank_and_comment_visual", kconfig.context.visual, {}, yank_and_comment)
kconfig.add_keymap("n", "kommentary_yank_and_comment_motion", kconfig.context.motion, {expr = true}, yank_and_comment)
-- Set up a regular keymapping to the new <Plug> mapping
vim.api.nvim_set_keymap('n', 'gcyy', '<Plug>kommentary_yank_and_comment_line', { silent = true })
vim.api.nvim_set_keymap('n', 'gcy', '<Plug>kommentary_yank_and_comment_motion', { silent = true })
vim.api.nvim_set_keymap('v', 'gcy', '<Plug>kommentary_yank_and_comment_visual', { silent = true })

vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default<esc>", {})


require'lightspeed'.setup {
	-- jump_to_first_match = true,
	jump_on_partial_input_safety_timeout = 400,
	highlight_unique_chars = false,
	grey_out_search_area = true,
	match_only_the_start_of_same_char_seqs = true,
	limit_ft_matches = 5,
}


require("which-key").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
}

-- fzf setup
require("fzf-lua").setup({
	-- fzf_layout = 'reverse',
	files = {
		cmd = 'fd -t file',
	},
	previewers = {
		builtin = {
			syntax_limit_l = 0,
			syntax_limit_b = 1024*1024,
		},
	},
	keymap = {
		fzf = {
			["tab"]      = "down",
			["btab"]     = "up",
		}
	},
})

-- load devicons
require'nvim-web-devicons'.setup {
	default = true;
}

-- colorscheme setup
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd[[colorscheme tokyonight]]

-- load	lualine
require('lualine').setup()

-- mundo
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

require"surround".setup {mappings_style = "surround"}
