local vim = vim

function dump(...)  ---@diagnostic disable-line
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

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

require('which-key').setup({ })

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
  undercurl = true,           -- enable undercurls
  overrides = {
    GitGutterAddLineNR = { fg = gitSigns.add }, -- diff mode: Added line |diff.txt|
    GitGutterChangeLineNR = { fg = gitSigns.change }, -- diff mode: Changed line |diff.txt|
    GitGutterDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    GitGutterChangeDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    TSVariable = {fg = 'wheat'},
  },
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

-- iron conf
local iron = require("iron.core")

iron.setup {
  config = {
    -- If iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- Whether a repl should be discarded or not
    scratch_repl = false,
    -- Your repl definitions come here
    scope = require("iron.scope").path_based,
    repl_definition = {
      sh = {
        command = {"zsh"}
      },
      python = require("iron.fts.python").ipython,
    },
    -- repl_open_cmd = require('iron.view').curry.right(60),
    repl_open_cmd = 'rightbelow vsplit',
    buflisted = false,
  },
  -- Iron doesn't set keymaps by default anymore. Set them here
  -- or use `should_map_plug = true` and map from you vim files
  keymaps = {
    send_motion = "<leader>r",
    visual_send = "<leader>r",
    send_file = "<leader>rf",
    send_line = "<leader>rr",
    send_mark = "<leader>rm",
    mark_motion = "<leader>rc",
    mark_visual = "<leader>rc",
    remove_mark = "<leader>rd",
    cr = "<leader>r<cr>",
    interrupt = "<leader>r<leader>",
    exit = "<leader>rq",
    clear = "<leader>rl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = false
  }
}

local smooth_colors = {
  Smooth1 = '#A10100',
  Smooth2 = '#DA1F05',
  Smooth3 = '#F33C04',
  Smooth4 = '#FE650D',
  Smooth5 = '#FFC11F',
  Smooth6 = '#FFF75D',
}

for name, fg in pairs(smooth_colors) do
  vim.api.nvim_set_hl(
    0,
    name,
    { fg = fg }
  )

end

require('smoothcursor').setup({
  autostart = true,
  cursor = "",             -- cursor shape (need nerd font)
  intervals = 35,           -- tick interval
  linehl = nil,             -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
  type = "default",         -- define cursor movement calculate function, "default" or "exp" (exponential).
  fancy = {
    enable = true,       -- enable fancy mode
    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
    body = {
      --[[ { cursor = "", texthl = "SmoothCursorRed" },
      { cursor = "", texthl = "SmoothCursorOrange" },
      { cursor = "●", texthl = "SmoothCursorYellow" },
      { cursor = "●", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" }, ]]
      { cursor = "", texthl = "Smooth1" },
      { cursor = "", texthl = "Smooth2" },
      { cursor = "●", texthl = "Smooth3" },
      { cursor = "•", texthl = "Smooth4" },
      { cursor = ".", texthl = "Smooth5" },
      { cursor = ".", texthl = "Smooth6" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" }
  },
  priority = 10,            -- set marker priority
  speed = 25,               -- max is 100 to stick to your current position
  texthl = "SmoothCursor",  -- highlight group, default is { bg = nil, fg = "#FFD400" }
  threshold = 3,
  timeout = 3000,
})

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
