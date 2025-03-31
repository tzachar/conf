local M = {}

function M.format_range_operator(...)
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    -- vim.lsp.buf.format({
    --   range = { start = start, ['end'] = finish },
    --   timeout_ms = 3000,
    --   -- name='null-ls',
    -- })
    require('conform').format({
      range = { start = start, ['end'] = finish },
      timeout_ms = 3000,
    })
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client:supports_method('textDocument/codeLens')
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = 'lsp_code_lens_refresh'
  local cl_events = { 'BufEnter', 'InsertLeave' }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })
  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = function(...)
      local ok2 = pcall(vim.lsp.codelens.refresh, { bufnr = bufnr })
      if not ok2 then
        vim.notify('Error calling codelense refresh', vim.log.levels.ERROR)
        return true -- remove this autocommand
      end
    end,
  })
end

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  -- Mappings.
  local opts = { noremap = true, silent = true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '', { noremap = true, silent = true, callback = require('actions-preview').code_actions })
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'dp', '<cmd>lua vim.diagnostic.jump({count = -1, float = false, severity = { min = vim.diagnostic.severity.HINT }})<CR>', opts)
  buf_set_keymap('n', 'dn', '<cmd>lua vim.diagnostic.jump({count = 1, float = false, severity = { min = vim.diagnostic.severity.HINT }})<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  buf_set_keymap('n', '<leader>f', '', { callback = M.format_range_operator, noremap = true, silent = true })
  buf_set_keymap('v', '<leader>f', '', { callback = M.format_range_operator, noremap = true, silent = true })
  -- vim.api.nvim_set_option_value('formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:3000})', { buf = bufnr })
  vim.api.nvim_set_option_value('formatexpr', "v:lua.require'conform'.formatexpr(#{timeout_ms:3000})", { buf = bufnr })

  -- buf_set_keymap('v', '<leader>f', ':lua vim.lsp.buf.range_formatting()<CR>', opts)

  --[[ -- disable formatting for pyright
  if client.name == 'pyright' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end ]]
  -- if client.server_capabilities.documentHighlightProvider then
  --       vim.api.nvim_exec([[
  --           augroup lsp_document_highlight
  --               autocmd! * <buffer>
  --               autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --               autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --           augroup END
  --           ]],
  --       false)
  -- end

  -- mark semantic
  if client:supports_method('textDocument/semanticTokens/full') then
    vim.b.semantic_tokens = true
  end
  if client:supports_method('textDocument/inlayHintProvider') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
  --   vim.lsp.buf.inlay_hint(bufnr, true)
  -- setup codelens
  M.setup_codelens_refresh(client, bufnr)
end

return M
