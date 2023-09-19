local function mason_post_install(pkg, _)
  if pkg.name ~= 'python-lsp-server' then
    return
  end

  vim.notify('Restart and run :PylspInstall python-lsp-ruff', vim.log.levels.WARN)
end

return {
  { 'neovim/nvim-lspconfig' },
  -- update language servers
  {
    'williamboman/mason.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall' },
    config = function()
      require('mason').setup()
      require('mason-registry'):on('package:install:success', vim.schedule_wrap(mason_post_install))
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = 'williamboman/mason.nvim',
  },
  -- ls progress
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {
      -- options
    },
  },

  { 'onsails/lspkind-nvim' },

  {
    'aznhe21/actions-preview.nvim',
    config = function()
      require('actions-preview').setup({
        backend = { 'nui', 'telescope' },
      })
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    config = function()
      local rt = require('rust-tools')
      rt.setup({
        tools = {
          rustfmt = {
            rangeFormatting = {
              enable = true,
            },
          },
          on_initialized = function()
            require('inlay-hints').set_all()
          end,
          inlay_hints = {
            auto = false,
            show_parameter_hints = true,
          },
        },
        server = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                -- need to make sure to add this one also to cargo config!!
                target = 'x86_64-unknown-linux-gnu',
              },
              inlayHints = {
                renderColons = false,
                -- lifetimeElisionHints = {
                --   enable = true,
                -- },
              },
            },
          },
          on_attach = function(client, bufnr)
            require('lsp_utils').on_attach(client, bufnr)
          end,
        },
      })
      rt.inlay_hints.set()
    end,
  },
  {
    'simrat39/inlay-hints.nvim',
    config = function()
      local ih = require('inlay-hints')
      ih.setup({
        only_current_line = false,
        eol = {
          right_align = false,
          parameter = {
            separator = ', ',
            format = function(hints)
              return string.format(' : %s', hints)
            end,
          },

          type = {
            separator = ', ',
            format = function(hints)
              return string.format('  %s', hints)
            end,
          },
        },
      })
    end,
  },
  -- {
  --   'lvimuser/lsp-inlayhints.nvim',
  --   branch = 'anticonceal',
  --   config = function()
  --     vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
  --     vim.api.nvim_create_autocmd('LspAttach', {
  --       group = 'LspAttach_inlayhints',
  --       callback = function(args)
  --         if not (args.data and args.data.client_id) then
  --           return
  --         end
  --
  --         local bufnr = args.buf
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         require('lsp-inlayhints').on_attach(client, bufnr)
  --       end,
  --     })
  --   end,
  -- },
}
