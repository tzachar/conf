require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  context_commentstring = {
    enable = true,
  },
  rainbow = {
    enable = true,
    max_file_lines = 800,
  },
  indent = {
    enable = true,
    disable = { 'py', 'python' },
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {
      --      "rust"
    }, -- list of language that will be disabled
    custom_captures = { -- mapping of user defined captures to highlight groups
      -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- mappings for incremental selection (visual mappings)
      init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
      node_incremental = 'grn', -- increment to the upper named parent
      scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
      node_decremental = 'grm', -- decrement to the previous node
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
    },
    highlight_current_scope = {
      enable = false,
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'gt',          -- mapping to rename reference under cursor
      },
    },
    navigation = {
      enable = false,
    },
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      --[[ peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      }, ]]
    },
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>gs'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>gS'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    ensure_installed = 'all',
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['<leader>;'] = 'textsubjects-big',
      ['<leader>"'] = 'textsubjects-smart',
    },
  },

  endwise = {
    enable = true,
  },
})


local ts_utils = require("nvim-treesitter.ts_utils")

local toggle_fstring = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local node = ts_utils.get_node_at_cursor()

  while (node ~= nil) and (node:type() ~= "string") do
    node = node:parent()
  end
  if node == nil then
    print("f-string: not in string node :(")
    return
  end

  local srow, scol, ecol, erow = ts_utils.get_vim_range({ node:range() })
  vim.fn.setcursorcharpos(srow, scol)
  local char = vim.api.nvim_get_current_line():sub(scol, scol)
  local is_fstring = (char == "f")

  if is_fstring then
    vim.cmd("normal x")
    -- if cursor is in the same line as text change
    if srow == cursor[1] then
      cursor[2] = cursor[2] - 1 -- negative offset to cursor
    end
  else
    vim.cmd("normal if")
    -- if cursor is in the same line as text change
    if srow == cursor[1] then
      cursor[2] = cursor[2] + 1 -- positive offset to cursor
    end
  end
  vim.api.nvim_win_set_cursor(0, cursor)
end

vim.keymap.set('n', 'F', toggle_fstring, { noremap = true })
