vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    rustfmt = {
      rangeFormatting = {
        enable = true,
      },
    },
    on_initialized = function() end,
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
    },
  },
  -- LSP configuration
  server = {
    -- TODO
    -- see https://github.com/hrsh7th/cmp-nvim-lsp/issues/72
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(client, bufnr)
      require('lsp_utils').on_attach(client, bufnr)
      -- you can also put keymaps in here
    end,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          -- need to make sure to add this one also to cargo config!!
          target = 'x86_64-unknown-linux-gnu',
        },
        -- check = {
        --   command = 'clippy',
        --   ignore = {'new_ret_no_self', },
        -- },
        inlayHints = {
          renderColons = true,
        },
        diagnostic = {
          refreshSupport = false,
        }
      },
    },
  },
}

return {
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local crates = require('crates')
      crates.setup({
        completion = {
          cmp = {
            enabled = true,
          },
          crates = {
            enabled = true, -- disabled by default
            max_results = 8, -- The maximum number of search results to display
            min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
          },
        },
        lsp = {
          enabled = true,
          on_attach = require('lsp_utils').on_attach,
          actions = true,
          completion = true,
          hover = true,
        },
      })
      -- add to cmp
      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
          require('cmp').setup.buffer({ sources = { { name = 'crates' } } })

          vim.keymap.set('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Toggle Crates.nvim' })
          vim.keymap.set('n', '<leader>cr', crates.reload, { silent = true, desc = 'Reload Crates.nvim' })

          vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { silent = true, desc = 'Show versions' })
          vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'Show geatures' })
          vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'Show dependencies' })

          vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update Crate' })
          vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update Crate' })
          vim.keymap.set('n', '<leader>ca', crates.update_all_crates, { silent = true, desc = 'Update all Crates' })
          vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade Crate' })
          vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade Crates' })
          vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade all Crates' })

          vim.keymap.set('n', '<leader>ce', crates.expand_plain_crate_to_inline_table, { silent = true, desc = 'Expand to inline table' })
          vim.keymap.set('n', '<leader>cE', crates.extract_crate_into_table, { silent = true, desc = 'Extract to table' })

          vim.keymap.set('n', '<leader>cH', crates.open_homepage, { silent = true, desc = 'Open Homepage' })
          vim.keymap.set('n', '<leader>cR', crates.open_repository, { silent = true, desc = 'Open Repo' })
          vim.keymap.set('n', '<leader>cD', crates.open_documentation, { silent = true, desc = 'Open Doc' })
          vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { silent = true, desc = 'Open creates.io' })
        end,
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'Aityz/cratesearch.nvim',
    config = function()
      require('cratesearch').setup()
    end,
  },
}
