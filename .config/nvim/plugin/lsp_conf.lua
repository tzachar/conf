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

local diagnostic_icons = {
  ERROR = '',
  WARN = '',
  HINT = '',
  INFO = '',
}

-- Define the diagnostic signs.
for severity, icon in pairs(diagnostic_icons) do
  local hl = 'DiagnosticSign' .. severity:sub(1, 1) .. severity:sub(2):lower()
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

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
  signs = false,
})

-- https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua
local md_namespace = vim.api.nvim_create_namespace('lsp_float')

---LSP handler that adds extra inline highlights, keymaps, and window options.
---Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
---@return function
local function enhanced_float_handler(handler)
  return function(err, result, ctx, config)
    local buf, win = handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend('force', config or {}, {
        border = 'rounded',
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
      })
    )

    if not buf or not win then
      return
    end

    -- Conceal everything.
    vim.wo[win].concealcursor = 'n'

    -- Extra highlights.
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
      for pattern, hl_group in pairs({
        ['|%S-|'] = '@text.reference',
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
      }) do
        local from = 1 ---@type integer?
        while from do
          local to
          from, to = line:find(pattern, from)
          if from then
            vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
              end_col = to,
              hl_group = hl_group,
            })
          end
          from = to and to + 1 or nil
        end
      end
    end

    -- Add keymaps for opening links.
    if not vim.b[buf].markdown_keys then
      vim.keymap.set('n', 'K', function()
        -- Vim help links.
        local url = (vim.fn.expand('<cWORD>') --[[@as string]]):match('|(%S-)|')
        if url then
          return vim.cmd.help(url)
        end

        -- Markdown links.
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        local from, to
        from, to, url = vim.api.nvim_get_current_line():find('%[.-%]%((%S-)%)')
        if from and col >= from and col <= to then
          vim.system({ 'open', url }, nil, function(res)
            if res.code ~= 0 then
              vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
            end
          end)
        end
      end, { buffer = buf, silent = true })
      vim.b[buf].markdown_keys = true
    end
  end
end

local methods = vim.lsp.protocol.Methods
vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)
