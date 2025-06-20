local vim = vim
local lsp_utils = require('lsp_utils')

require('cmp_nvim_lsp').setup({})

local DebounceRate = 5000

local function setup_servers()
  local library = {}
  local path = vim.split(package.path, ';')

  -- this is the ONLY correct way to setup your path
  table.insert(path, 'lua/?.lua')
  table.insert(path, 'lua/?/init.lua')

  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib, false, true)) do
      if vim.uv ~= nil and vim.uv.fs_realpath ~= nil then
        p = vim.uv.fs_realpath(p)
      else
        p = vim.loop.fs_realpath(p)
      end
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
  configs['clangd'] = {}
  configs['harper_ls'] = {
    filetypes = { 'txt', 'md' },
    autostart = false,
    settings = {
      ['harper-ls'] = {
        linters = {
          SentenceCapitalization = false,
          SpellCheck = false,
        },
      },
    },
  }
  configs['vale_ls'] = {}
  configs['cssls'] = {}
  configs['vimls'] = {}
  configs['yamlls'] = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  }
  -- configs['pyrefly'] = {
  --   settings = {
  --   },
  -- }
  configs['basedpyright'] = {
    settings = {
      basedpyright = {
        analysis = {
          -- diagnosticMode = 'openFilesOnly',
          typeCheckingMode = 'off',
          diagnosticSeverityOverrides = {
            strictDictionaryInference = 'warning',
            reportMissingImports = 'error',
            reportUndefinedVariable = 'error',
            reportUnusedExpression = 'warning',
            reportCallIssue = 'error',
            reportIndexIssue = 'error',
            reportUnhashable = 'error',
            reportUnusedExcept = 'error',
            reportPossiblyUnboundVariable = 'error',
            reportDuplicateImport = 'error',
            reportUnusedImport = 'warning',
            reportUnusedVariable = 'warning',
            reportMissingParameterType = false,
            reportUnknownParameterType = false,
            reportUnknownArgumentType = false,
            reportUnknownMemberType = false,
            reportImplicitOverride = false,
            reportUnknownVariableType = false,
          },
        },
      },
    },
  }
  -- configs['pylsp'] = {
  --   root_dir = function(filename, bufnr)
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
  --     pylsp = {
  --       configurationSources = { 'flake8' },
  --       plugins = {
  --         -- make sure to install with PylspInstall python-lsp-ruff
  --         ruff = {
  --           enabled = true,
  --           extendSelect = { 'I' },
  --           ignore = {},
  --           lineLength = 160,
  --         },
  --         jedi_completion = {
  --           enabled = true,
  --           fuzzy = true,
  --         },
  --         jedi_hover = { enabled = true },
  --         jedi_references = { enabled = true },
  --         jedi_signature_help = { enabled = true },
  --         jedi_symbols = { enabled = true, all_scopes = true },
  --         pycodestyle = { enabled = false },
  --         autopep8 = { enabled = true },
  --         flake8 = {
  --           enabled = false,
  --           ignore = {},
  --           maxLineLength = 160,
  --         },
  --         mypy = { enabled = false },
  --         pyflakes = { enabled = false },
  --         isort = { enabled = false },
  --         yapf = { enabled = false },
  --         pylint = { enabled = false },
  --         pydocstyle = { enabled = false },
  --         mccabe = {
  --           enabled = false,
  --           threshold = 25,
  --         },
  --         preload = { enabled = false },
  --         rope_completion = { enabled = false },
  --         rope_autoimport = { enabled = false },
  --       },
  --     },
  --   },
  -- }
  configs['sqlls'] = {
    -- single_file_support = true,
  }
  configs['graphql'] = {}
  configs['buf_ls'] = {}
  configs['lua_ls'] = {
    filetypes = { 'lua' },
    settings = {
      Lua = {
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
    filetypes = { 'json' },
    settings = {
      jsonls = {},
    },
  }
  configs['bashls'] = {
    filetypes = { 'sh', 'zsh' },
    settings = {
      bashls = {},
    },
  }
  configs['ts_ls'] = {
    settings = {
      tsserver = {
        -- filetypes = { "sh", "zsh" };
      },
    },
  }
  configs['html'] = {
    filetypes = { 'html', 'css' },
    settings = {
      html = {},
    },
  }
  return configs
end

local lsp_configs = setup_servers()

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})
vim.keymap.set('n', '<leader>l', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

require('mason-lspconfig').setup({
  -- ensure_installed = vim.tbl_extend('keep', vim.tbl_keys(lsp_configs), { 'rust_analyzer' }),
  automatic_enable = true,
  ensure_installed = vim.tbl_keys(lsp_configs),
})
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities(capabilities))
-- [Additional capabilities customization]

for server, opts in pairs(lsp_configs) do
  opts['capabilities'] = capabilities
  opts['on_attach'] = lsp_utils.on_attach
  opts['flags'] = {
    debounce_text_changes = DebounceRate,
  }
  vim.lsp.config(server, opts)
end

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

local diagnostic_icons = {
  ERROR = '',
  WARN = '',
  HINT = '',
  INFO = '',
}

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = 'rounded',
    source = 'if_many',
    -- Show severity icons as prefixes.
    prefix = function(diag)
      local level = vim.diagnostic.severity[diag.severity]
      local prefix = string.format(' %s ', diagnostic_icons[level])
      return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
    end,
  },
  -- Disable signs in the gutter.
  signs = {
    text = diagnostic_icons,
  },
})

-- https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    border = 'rounded',
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    border = 'rounded',
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end

-- temp fix for rust analyzer
-- https://github.com/neovim/neovim/issues/30985
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
