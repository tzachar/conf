local vim = vim
-- iron conf
require('nrpattern').setup()
local iron = require('iron')

iron.core.set_config({
  preferred = {
    python = 'ipython',
  },
  memory_management = 'singleton',
  highlight_last = false,
})

function dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

local function add_ignore_type(options)
  local comment_str = require('kommentary.config').get_config(0)[1]
  local ignore_decl = '  ' .. comment_str .. ' type: ignore'
  for linenr = (options.line1 - 1 or vim.fn.line('.') - 1), (options.line2 - 1 or vim.fn.line('.') - 1) do
    local line = vim.api.nvim_buf_get_lines(0, linenr, linenr + 1, true)[1]
    if string.sub(line, -#ignore_decl, -1) == ignore_decl then
      vim.api.nvim_buf_set_text(0, linenr, #line - #ignore_decl, linenr, #line, {})
    elseif #(vim.diagnostic.get(0, { lnum = linenr })) > 0 then
      vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, { ignore_decl })
    end
  end
end
vim.api.nvim_add_user_command('AddIgnoreType', add_ignore_type, { range = true })

local nest = require('nest')
nest.applyKeymaps({
  { mode = 'n', {
    { '<C-i>', '<cmd>AddIgnoreType<cr>', options = { silent = true } },
  } },
  { mode = 'v', {
    { '<C-i>', ':AddIgnoreType<cr>', options = { silent = true } },
  } },
})

local kconfig = require('kommentary.config')
local kommentary = require('kommentary.kommentary')

local function yank_and_comment(...)
  local args = { ... }
  local start_line = args[1]
  local end_line = args[2]
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  vim.api.nvim_command(tostring(start_line) .. ',' .. tostring(end_line) .. 'y')
  kommentary.toggle_comment_range(start_line, end_line, kconfig.get_modes().normal)
  vim.fn.feedkeys('<ctrl-c>')
end

kconfig.add_keymap('n', 'kommentary_yank_and_comment_line', kconfig.context.line, { expr = true }, yank_and_comment)
kconfig.add_keymap('v', 'kommentary_yank_and_comment_visual', kconfig.context.visual, {}, yank_and_comment)
kconfig.add_keymap('n', 'kommentary_yank_and_comment_motion', kconfig.context.motion, { expr = true }, yank_and_comment)
-- Set up a regular keymapping to the new <Plug> mapping
vim.api.nvim_set_keymap('n', 'gcyy', '<Plug>kommentary_yank_and_comment_line', { silent = true })
vim.api.nvim_set_keymap('n', 'gcy', '<Plug>kommentary_yank_and_comment_motion', { silent = true })
vim.api.nvim_set_keymap('v', 'gcy', '<Plug>kommentary_yank_and_comment_visual', { silent = true })

vim.api.nvim_set_keymap('n', 'gcc', '<Plug>kommentary_line_default', {})
vim.api.nvim_set_keymap('n', 'gc', '<Plug>kommentary_motion_default', {})
vim.api.nvim_set_keymap('v', 'gc', '<Plug>kommentary_visual_default<esc>', {})

require('which-key').setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})

-- fzf setup
require('fzf-lua').setup({
  -- fzf_layout = 'reverse',
  files = {
    cmd = 'fd -t file',
  },
  previewers = {
    builtin = {
      syntax_limit_l = 0,
      syntax_limit_b = 1024 * 1024,
    },
  },
  keymap = {
    fzf = {
      ['tab'] = 'down',
      ['btab'] = 'up',
    },
  },
})

-- load devicons
require('nvim-web-devicons').setup({
  default = true,
})

-- colorscheme setup
--[[ vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd("colorscheme tokyonight") ]]

-- gitSigns taken from tokyonight
local gitSigns = { change = '#6183bb', add = '#449dab', delete = '#914c54', conflict = '#bb7a61' }
require('kanagawa').setup({
  overrides = {
    GitGutterAddLineNR = { fg = gitSigns.add }, -- diff mode: Added line |diff.txt|
    GitGutterChangeLineNR = { fg = gitSigns.change }, -- diff mode: Changed line |diff.txt|
    GitGutterDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    GitGutterChangeDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
  },
})
vim.cmd('colorscheme kanagawa')

-- load	lualine
require('lualine').setup()

-- mundo
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

-- require"surround".setup {mappings_style = "surround"}
