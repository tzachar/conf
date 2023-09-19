local vim = vim
local lspconfig = require('lspconfig')
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
      p = vim.uv.fs_realpath(p)
      -- p = vim.loop.fs_realpath(p)
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

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- lsp_lines: disable virtual text for diagnostics
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(lsp_configs),
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities(capabilities))
-- [Additional capabilities customization]
-- Large workspace scanning may freeze the UI; see https://github.com/neovim/neovim/issues/23291
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

for server, opts in pairs(lsp_configs) do
  opts['capabilities'] = capabilities
  opts['on_attach'] = lsp_utils.on_attach
  opts['flags'] = {
    debounce_text_changes = DebounceRate,
  }
  lspconfig[server].setup(opts)
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
