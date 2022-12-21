local vim = vim

local ignore_decl_per_source = {
  ['Pyright'] = 'type: ignore',
  ['mypy'] = 'type: ignore',
  ['flake8']  = 'noqa',
  ['pyflakes']  = 'noqa',
  ['pycodestyle']  = 'noqa',
  ['pylsp']  = 'noqa',
  ['Lua Diagnostics.'] = '-@diagnostic disable-line',
  ['Lua Syntax Check.'] = '-@diagnostic disable-line',
}

local function add_ignore_type(options)
  local comment_str = vim.bo.commentstring:gsub('%%s', '')
  if not comment_str then
    return
  end
  for linenr = (options.line1 - 1 or vim.fn.line('.') - 1), (options.line2 - 1 or vim.fn.line('.') - 1) do
    local diag = vim.diagnostic.get(0, { lnum = linenr })
    if #diag > 0 and ignore_decl_per_source[diag[1].source] == nil then
      dump('cannot find ignore type: ', diag[1].source)
    end
    for source, ignore_decl in pairs(ignore_decl_per_source) do
      local line = vim.api.nvim_buf_get_lines(0, linenr, linenr + 1, true)[1]
      ignore_decl = '  ' .. comment_str .. ignore_decl
      if string.sub(line, -#ignore_decl, -1) == ignore_decl then
        vim.api.nvim_buf_set_text(0, linenr, #line - #ignore_decl, linenr, #line, {})
        return
      elseif #diag > 0 and diag[1].source == source then
        vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, { ignore_decl })
        return
      end
    end
  end
end
vim.api.nvim_create_user_command('AddIgnoreType', add_ignore_type, { range = true })

local nest = require('nest')
nest.applyKeymaps({
  { mode = 'n', {
    { '<C-i>', '<cmd>AddIgnoreType<cr>', options = { silent = true } },
    { '<TAB>', '<cmd>AddIgnoreType<cr>', options = { silent = true } },
  } },
  { mode = 'v', {
    { '<C-i>', ':AddIgnoreType<cr>', options = { silent = true } },
    { '<TAB>', ':AddIgnoreType<cr>', options = { silent = true } },
  } },
})

require('Comment').setup({
  padding = true,
  sticky = true,
  mappings = { basic = true, extra = true, },
})
nest.applyKeymaps({
  { mode = 'n', {
    { 'gc<space>', '<Plug>(comment_toggle_linewise_current)', options = { silent = true } },
  } }
})

local function yank_and_comment(options)
  local comment_api = require('Comment.api')
  local start_line = (options.line1 or vim.fn.line('.')) - 1
  local end_line = options.line2 or vim.fn.line('.')
  local original_text = vim.api.nvim_buf_get_lines(
    0,
    start_line,
    end_line,
    false)
  comment_api.comment.linewise.count(end_line - start_line)
  vim.fn.setreg('', original_text)
  vim.fn.setreg('+', original_text)
end

vim.api.nvim_create_user_command('YankAndComment', yank_and_comment, { range = true })
nest.applyKeymaps({
  { mode = 'n', {
    { 'gcy', '<cmd>YankAndComment<cr>', options = { silent = true } },
  } },
  { mode = 'v', {
    { 'gcy', ':YankAndComment<cr>', options = { silent = true } },
  } },
})


require('which-key').setup({ })

-- fzf setup
-- require('fzf-lua').setup({
--   -- fzf_layout = 'reverse',
--   buffers = {
--     sort_lastused = false,
--   },
--   files = {
--     cmd = 'fd -t file',
--   },
--   previewers = {
--     builtin = {
--       syntax_limit_l = 0,
--       syntax_limit_b = 1024 * 1024,
--     },
--   },
--   keymap = {
--     fzf = {
--       ['tab'] = 'down',
--       ['btab'] = 'up',
--     },
--   },
-- })

-- load devicons
require('nvim-web-devicons').setup({
  default = true,
})

vim.cmd('colorscheme kanagawa')

-- load	lualine
require('lualine').setup({
      options = {
        globalstatus = false
    },
})

-- mundo
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

local surround = require("nvim-surround.config")
require("nvim-surround").setup({
  surrounds = {
    ["f"] = {
      add = function()
        local result = surround.get_input("Enter the function name: ")
        if result then
          return { { result .. "(" }, { ")" } }
        end
      end,
    }
  }
})

local surround_print = {
  lua = 'dump',
  python = 'print',
  js = 'console.log',
  html = 'console.log',
}

surround.buffer_setup({
  surrounds = {
    ["p"] = {
      add = function()
        local print = surround_print[vim.bo.filetype] or 'print'
        return { { print .. "(" }, { ")" } }
      end,
      find = function()
        local print = surround_print[vim.bo.filetype] or 'print'
        return surround.get_selection({pattern = print .. "%b()"})
      end,
      delete = function()
        local print = surround_print[vim.bo.filetype] or 'print'
        return surround.get_selections({char = "p", pattern = "^(" .. print .. "%()().-(%))()$"})
      end,
      change = {
        target = function()
          local print = surround_print[vim.bo.filetype] or 'print'
          return surround.get_selections({char = "p", pattern = "^(" .. print .. "%()().-(%))()$"})
        end
      },
    },
  }
})

require('nest').applyKeymaps({
  {
    mode = 'n',
    {
      {
        'yp',
        function()
          vim.fn.feedkeys('yy')
          vim.fn.feedkeys('yssp')
          vim.fn.feedkeys('p')
        end,
        buffer = true,
        options = { silent = false }
      },
      {
        'yP',
        function()
          vim.fn.feedkeys('yy')
          vim.fn.feedkeys('yssp')
          vim.fn.feedkeys('P')
        end,
        buffer = true,
        options = { silent = false }
      },
    }
  }
})

-- indend-guides setup
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
}

-- live command setup
require("live-command").setup({
  commands = {
    Norm = { cmd = "norm" },
  }
})


-- dial
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.integer.alias.binary,
    augend.constant.alias.bool,
    augend.constant.new{ elements = {"True", "False"} }
  },
}
