local function get_node_at_position(row, col)
  return vim.treesitter.get_node({
    bufnr = 0,
    pos = { row, col },
  })
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

  for i = cursor[2], max_col do
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

  local node = find_node_type_zoom_out_first({ 'string', 'program' })
  if node == nil then
    print('f-string: not in string node :(')
    return
  end

  local srow, scol, _, _ = vim.treesitter.get_node_range(node)
  srow = srow + 1
  scol = scol + 1
  vim.fn.setcursorcharpos(srow, scol)
  local char = vim.api.nvim_get_current_line():sub(scol, scol)
  local is_fstring = (char == 'f')

  if is_fstring then
    vim.cmd('normal x')
    -- if cursor is in the same line as text change
    if srow == cursor[1] and cursor[2] >= scol then
      cursor[2] = cursor[2] - 1 -- negative offset to cursor
    end
  else
    vim.cmd('normal if')
    -- if cursor is in the same line as text change
    if srow == cursor[1] and cursor[2] >= scol then
      cursor[2] = cursor[2] + 1 -- positive offset to cursor
    end
  end
  cursor[2] = math.max(cursor[2], 0)
  vim.api.nvim_win_set_cursor(0, cursor)
end

vim.keymap.set('n', '<leader><leader>', toggle_fstring, { noremap = true })

-- incremental selection, skip the init_selection function...
-- local inc_select = require('nvim-treesitter.incremental_selection')
-- vim.keymap.set('n', '<M-k>', inc_select.init_selection, { silent = true, noremap = true, desc = 'Node incremental selection' })

local function format_sql(text)
  for idx, line in ipairs(text) do
    -- dump(text[idx])
    text[idx] = line:gsub('^%s+', ''):gsub('%s+$', '')
    dump(text[idx])
  end
  local j = require('plenary.job'):new({
    command = 'python',
    args = {
      '-c',
      -- 'from sql_formatter.core import format_sql; import sys; print(format_sql(sys.stdin.read()))'
      [[
import sqlparse
import sys
print(
      sqlparse.format(
        sys.stdin.read(),
        reindent=True,
        keyword_case="upper",
        indent_columns=True,
        identifier_case='lower',
        output_format='sql',
        wrap_after=80,
        comma_first=True,
        reindent_aligned=True,
      ).strip()
)
]],
    },
    writer = text,
  })
  local output = j:sync()
  local filtered = {}
  for _, line in ipairs(output) do
    if #line > 0 then
      filtered[#filtered + 1] = line
    end
  end
  dump(filtered)
  return filtered
end

function Format_sql_operator(...)
  local bufnr = vim.api.nvim_get_current_buf()
  _G.op_func_sql_formatting = function()
    local startpos = vim.api.nvim_buf_get_mark(bufnr, '[')
    local endpos = vim.api.nvim_buf_get_mark(bufnr, ']')
    local srow = startpos[1] - 1
    local scol = startpos[2]
    local erow = endpos[1] - 1
    local ecol = endpos[2] + 1
    local org_text = vim.api.nvim_buf_get_text(bufnr, srow, scol, erow, ecol, {})
    local indentation = string.match(org_text[1], '^%s+') or ''
    local text = format_sql(org_text)
    for idx, line in ipairs(text) do
      text[idx] = indentation .. line
    end
    vim.api.nvim_buf_set_text(bufnr, srow, scol, erow, ecol, text)
    -- vim.go.operatorfunc = old_func
    -- _G.op_func_sql_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_sql_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>sf', '<cmd>lua Format_sql_operator()<CR>', opts)
vim.api.nvim_set_keymap('v', '<leader>sf', '<cmd>lua Format_sql_operator()<CR>', opts)
