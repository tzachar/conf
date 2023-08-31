local vim = vim
local lspconfig = require('lspconfig')

require('cmp_nvim_lsp').setup({})

function Format_range_operator(...)
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    vim.lsp.buf.format({
      range = { start = start, ['end'] = finish },
      timeout_ms = 3000,
      -- name='null-ls',
    })
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '', { noremap = true, silent = true, callback = require('actions-preview').code_actions })
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'dp', '<cmd>lua vim.diagnostic.goto_prev({float = false})<CR>', opts)
  buf_set_keymap('n', 'dn', '<cmd>lua vim.diagnostic.goto_next({float = false})<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  buf_set_keymap('n', '<leader>f', '<cmd>lua Format_range_operator()<CR>', opts)
  buf_set_keymap('v', '<leader>f', '<cmd>lua Format_range_operator()<CR>', opts)
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:3000})')

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

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- lsp_lines: disable virtual text for diagnostics
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
  })
  -- mark semantic
  local caps = client.server_capabilities
  if client.name ~= 'null-ls' and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    vim.b.semantic_tokens = true
  end
  if caps.inlayHintProvider then
    --   vim.lsp.buf.inlay_hint(bufnr, true)
    require('inlay-hints').on_attach(client, bufnr)
  end
end

local DebounceRate = 5000

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
  add('~/.local/share/nvim/lazy/*')

  local configs = {}
  configs['cssls'] = {}
  configs['vimls'] = {}
  configs['yamlls'] = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  }
  -- configs['pylyzer'] = {
  --   root_dir = function(filename)
  --     local util = require('lspconfig.util')
  --     local root = util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile')(filename)
  --     if root then
  --       return root
  --     end
  --     root = util.find_git_ancestor(filename)
  --     if root then
  --       return root
  --     end
  --     return vim.fs.dirname(filename)
  --   end,
  --   settings = {
  --     python = {
  --       checkOnType = false,
  --       diagnostics = true,
  --       inlayHints = true,
  --       smartCompletion = true
  --     },
  --   },
  -- }
  -- configs['rust_analyzer'] = {
  --   settings = {
  --     ["rust-analyzer"] = {
  --       rustfmt = {
  --         rangeFormatting = {
  --           enable = true
  --         },
  --       },
  --     },
  --   },
  -- }
  configs['pylsp'] = {
    root_dir = function(filename, bufnr)
      local util = require('lspconfig.util')
      local root = util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile')(filename)
      if root then
        return root
      end
      root = util.find_git_ancestor(filename)
      if root then
        return root
      end
      return vim.fs.dirname(filename)
    end,
    settings = {
      pylsp = {
        configurationSources = { 'flake8' },
        plugins = {
          -- make sure to install with PylspInstall python-lsp-ruff
          ruff = {
            enabled = true,
            extendSelect = { 'I' },
            ignore = {},
            lineLength = 160,
          },
          jedi_completion = {
            enabled = true,
            fuzzy = true,
          },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true, all_scopes = true },
          pycodestyle = { enabled = false },
          autopep8 = { enabled = true },
          flake8 = {
            enabled = false,
            ignore = {},
            maxLineLength = 160,
          },
          mypy = { enabled = false },
          pyflakes = { enabled = false },
          isort = { enabled = false },
          yapf = { enabled = false },
          pylint = { enabled = false },
          pydocstyle = { enabled = false },
          mccabe = {
            enabled = false,
            threshold = 25,
          },
          preload = { enabled = false },
          rope_completion = { enabled = false },
          rope_autoimport = { enabled = false },
        },
      },
    },
  }
  configs['sqlls'] = {
    -- single_file_support = true,
  }
  configs['graphql'] = {}
  configs['lua_ls'] = {
    settings = {
      Lua = {
        filetypes = { 'lua' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        hint = {
          enable = true,
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
    settings = {
      jsonls = {
        filetypes = { 'json' },
      },
    },
  }
  configs['bashls'] = {
    settings = {
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
    },
  }
  configs['tsserver'] = {
    settings = {
      tsserver = {
        -- filetypes = { "sh", "zsh" };
      },
    },
  }
  configs['html'] = {
    settings = {
      html = {
        filetypes = { 'html', 'css' },
      },
    },
  }
  return configs
end

local lsp_configs = setup_servers()

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(lsp_configs),
})

for server, opts in pairs(lsp_configs) do
  opts['capabilities'] = capabilities
  opts['on_attach'] = on_attach
  opts['flags'] = {
    debounce_text_changes = DebounceRate,
  }
  lspconfig[server].setup(opts)
end

require('fidget').setup({})

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
