local vim = vim

local ignore_decl_per_source = {
  ['Pyright'] = 'type: ignore',
  ['basedpyright'] = 'type: ignore',
  ['mypy'] = 'type: ignore',
  ['flake8'] = 'noqa',
  ['pyflakes'] = 'noqa',
  ['ruff'] = 'noqa',
  ['pycodestyle'] = 'noqa',
  ['pylsp'] = 'noqa',
  ['Pyrefly'] = ' pyrefly: ignore',
  ['Lua Diagnostics.'] = '-@diagnostic disable-line',
  ['Lua Syntax Check.'] = '-@diagnostic disable-line',
}

local function add_ignore_type(options)
  local comment_str = vim.bo.commentstring:gsub('%%s', ''):gsub('%s+', '')
  if not comment_str then
    return
  end
  for linenr = (options.line1 - 1 or vim.fn.line('.') - 1), (options.line2 - 1 or vim.fn.line('.') - 1) do
    local diag = vim.diagnostic.get(0, { lnum = linenr })
    if #diag > 0 and ignore_decl_per_source[diag[1].source] == nil then
      dump('cannot find ignore type: ', diag[1].source)
    end
    (function()
      for source, ignore_decl in pairs(ignore_decl_per_source) do
        local line = vim.api.nvim_buf_get_lines(0, linenr, linenr + 1, true)[1]
        local ignore_decl_expr = '^(.*)%s*' .. comment_str .. '%s*' .. ignore_decl
        local match = line:match(ignore_decl_expr)
        ignore_decl = '  ' .. comment_str .. ignore_decl
        -- if string.sub(line, -#ignore_decl, -1) == ignore_decl then
        if match then
          vim.api.nvim_buf_set_text(0, linenr, 0, linenr, #line, { match })
          return
        elseif #diag > 0 and diag[1].source == source then
          vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, { ignore_decl })
          return
        end
      end
    end)()
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

-- mundo
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

vim.api.nvim_create_user_command('AddIgnoreType', add_ignore_type, { range = true })

local function convert_to_json_list(options)
  local lines = vim.api.nvim_buf_get_lines(0, options.line1 - 1, options.line2, true)
  local new_lines = {}
  for i = 1, #lines do
    lines[i] = lines[i]:match('^%s*(.-)%s*$')
    if #lines[i] > 0 then
      table.insert(new_lines, '"' .. lines[i] .. '",')
    end
  end
  vim.api.nvim_buf_set_lines(0, options.line1 - 1, options.line2, true, new_lines)
  -- format
  vim.fn.feedkeys('gqab')
end
vim.api.nvim_create_user_command('ToJSONList', convert_to_json_list, { range = true })

-- setup K
local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ 'vim', 'help' }, filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'man' }, filetype) then
    vim.cmd('Man ' .. vim.fn.expand('<cword>'))
  elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

vim.keymap.set('n', 'K', show_documentation, { silent = true })
