local vim = vim
require('cmp_nvim_lsp').setup({})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    dump('no format')
  end

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
  })
end

local DebounceRate = 2000

local function setup_servers()
  local library = {}
  local path = vim.split(package.path, ';')

  -- this is the ONLY correct way to setup your path
  table.insert(path, 'lua/?.lua')
  table.insert(path, 'lua/?/init.lua')

  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib, false, true)) do
      p = vim.loop.fs_realpath(p)
      library[p] = true
    end
  end

  -- add runtime
  add('$VIMRUNTIME')

  -- add your config
  add('~/.config/nvim')

  -- add plugins
  -- if you're not using packer, then you might need to change the paths below
  add('~/.local/share/nvim/site/pack/packer/opt/*')
  add('~/.local/share/nvim/site/pack/packer/start/*')

  local configs = {}
  configs['cssls'] = {}
  configs['vimls'] = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  configs['sumneko_lua'] = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = DebounceRate,
    },
    settings = {
      Lua = {
        filetypes = { 'lua' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = library,
          maxPreload = 3000,
          checkThirdParty = false,
          preloadFileSize = 50000,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  }
  configs['jsonls'] = {
    on_attach = on_attach,
    settings = {
      jsonls = {
        filetypes = { 'json' },
      },
    },
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  configs['bashls'] = {
    on_attach = on_attach,
    settings = {
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
    },
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  configs['tsserver'] = {
    on_attach = on_attach,
    settings = {
      tsserver = {
        -- filetypes = { "sh", "zsh" };
      },
    },
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  configs['html'] = {
    on_attach = on_attach,
    settings = {
      html = {
        filetypes = { 'html', 'css' },
      },
    },
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  configs['pyright'] = {
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          stubPath = vim.env.HOME .. '/.local/share/python-type-stubs',
          typeshedPaths = vim.env.HOME .. '/.local/share/typeshed',
          autoImportCompletions = true,
        },
      },
    },
    flags = {
      debounce_text_changes = DebounceRate,
    },
  }
  return configs
end

local lsp_configs = setup_servers()

local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
  if lsp_configs[server.name] == nil then
    vim.notify('cannot find config for server:' .. server.name)
  end
  local opts = lsp_configs[server.name] or {}
  opts['capabilities'] = capabilities
  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  -- vim.cmd [[ do User LspAttachBuffers ]]
end)

for server, _ in pairs(lsp_configs) do
  local ok, lsp_server = lsp_installer.get_server(server)
  if ok then
    if not lsp_server:is_installed() then
      lsp_server:install()
    end
  end
end

-- lsp fzf integration
require('lspfuzzy').setup({})

vim.g.lsp_utils_location_opts = {
  height = 24,
  mode = 'editor',
  preview = {
    title = 'Location Preview',
    border = true,
    coloring = true,
  },
  keymaps = {
    n = {
      ['<C-n>'] = 'j',
      ['<C-p>'] = 'k',
    },
  },
}
vim.g.lsp_utils_symbols_opts = {
  height = 0,
  mode = 'editor',
  preview = {
    title = 'Symbol Preview',
    border = true,
    coloring = true,
  },
  keymaps = {
    n = {
      ['<C-n>'] = 'j',
      ['<C-p>'] = 'k',
    },
  },
}

-- highlight line numbers on error
vim.cmd([[
  highlight LspDiagnosticsLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight LspDiagnosticsLineNrWarning guibg=#51412A guifg=#FFA500 gui=bold
  highlight LspDiagnosticsLineNrInformation guibg=#1E535D guifg=#00FFFF gui=bold
  highlight LspDiagnosticsLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsLineNrError
  sign define DiagnosticSignWarn text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsLineNrWarning
  sign define DiagnosticSignInfo text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsLineNrInformation
  sign define DiagnosticSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsLineNrHint
]])
