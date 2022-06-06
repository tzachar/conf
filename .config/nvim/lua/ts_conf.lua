local ts_utils = require("nvim-treesitter.ts_utils")

require('nvim-treesitter.configs').setup({
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
      enable = false,
      --[[ keymaps = {
        smart_rename = 'gt',          -- mapping to rename reference under cursor
      }, ]]
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
    ensure_installed = {
      'python',
      'c',
      'cpp',
      'json',
      'bash',
      'html',
      'css',
      'lua',
    },
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

  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = {},  -- optional, list of language that will be disabled
  },
})

local function get_node_at_position(row, col)
  local root = ts_utils.get_root_for_position(row, col)
  if root == nil then
    return
  end
  return root:named_descendant_for_range(row, col, row, col)
end

local zoom_out = function(node, types)
    while (node ~= nil) and (not vim.tbl_contains(types, node:type())) do
      node = node:parent()
    end
  return node
end

local function find_node_type_zoom_out_first(types)
  local target_node = nil
  local cursor = vim.api.nvim_win_get_cursor(0)
  local max_col = #vim.api.nvim_get_current_line()

  for i=cursor[2], max_col do
    target_node = get_node_at_position(cursor[1] - 1, i)
    if target_node and vim.tbl_contains(types, target_node:type()) then
      break
    elseif target_node then
      -- try zooming out
      target_node = zoom_out(target_node, types)
    end
    if target_node and vim.tbl_contains(types, target_node:type()) then
      break
    end
  end
  return target_node
end


local toggle_fstring = function()
  local cursor = vim.api.nvim_win_get_cursor(0)

  local node = find_node_type_zoom_out_first({"string"})
  if node == nil then
    print("f-string: not in string node :(")
    return
  end

  local srow, scol, erow, ecol = ts_utils.get_vim_range({ node:range() })
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

local split_join = function(split)
  -- local target_node = ts_utils.get_node_at_cursor()
  local arguments = {
    "arguments",
    "argument_list",
    "parameter_list",
    "parameters",
    "list",
    "tuple",
    "dictionary",
  }

  local target_node = find_node_type_zoom_out_first(arguments)

  if target_node == nil then
    print("cannot find argument list :(")
    return
  end

  if target_node:child_count() == 0 then
    return
  end

  local replacement_text = {''}
  for argument_node in target_node:iter_children() do
    if argument_node:named() then
      table.insert(
        replacement_text,
        vim.treesitter.query.get_node_text(argument_node, 0).. ','
      )
    end
  end
  table.insert(replacement_text, '')

  if not split then
    replacement_text = table.concat(replacement_text, ' ')
    replacement_text = replacement_text:sub(2, -3)
    replacement_text = {replacement_text}
  end

  local srow, scol, erow, ecol = target_node:range()
  vim.api.nvim_buf_set_text(0, srow, scol + 1, erow, ecol - 1, replacement_text)
  vim.api.nvim_win_set_cursor(0, {srow + 1, scol})
  vim.cmd("normal " .. #replacement_text .. '==')
end

vim.keymap.set('n', '<leader>ss', function() split_join(true) end, { noremap = true })
vim.keymap.set('n', '<leader>sd', function() split_join(false) end, { noremap = true })


local ask_install = {}
function EnsureTSParserInstalled()
  local parsers = require('nvim-treesitter.parsers')
  local lang = parsers.get_buf_lang()
  if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
    vim.schedule_wrap(function()
      local res = vim.fn.confirm(
        'Install treesitter parser for ' .. lang ,
        '&Yes\n&No',
        1)
      if res == 1 then
        vim.cmd('TSInstall ' .. lang)
      else
        ask_install[lang] = false
      end
    end)()
  end
end

local ts_au = vim.api.nvim_create_augroup("TsAu", {clear = true})
vim.api.nvim_create_autocmd('FileType', {
  group = ts_au,
  pattern = '*',
  callback = function()
    EnsureTSParserInstalled()
  end
})
