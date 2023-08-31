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
                -- lifetimeElisionHints = {
                --   enable = true,
                -- },
              },
            },
          },
          on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '', { noremap = true, silent = true, callback = require('actions-preview').code_actions })
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dp', '<cmd>lua vim.diagnostic.goto_prev({float = false})<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'dn', '<cmd>lua vim.diagnostic.goto_next({float = false})<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua Format_range_operator()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>f', '<cmd>lua Format_range_operator()<CR>', opts)
            vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:3000})')
            require('inlay-hints').on_attach(client, bufnr)
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
