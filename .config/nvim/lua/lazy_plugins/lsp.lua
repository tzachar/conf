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
        backend = { 'snacks' },
        snacks = {
          layout = {
            -- this is the same as "vertical", but flipped
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            }
          },
          win = {
            preview = {
              on_buf = function()
                vim.fn.feedkeys('jj')
              end,
            },
          },
        },
      })
    end,
  },
  -- formatting
  {
    'stevearc/conform.nvim',
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        stop_after_first = true,
      },
      formatters_by_ft = {
        rust = { 'rustfmt' },
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'isort', 'black' },
        -- Use a sub-list to run only the first available formatter
        javascript = { 'prettierd', 'prettier' },
        cpp = { 'clang-format' },
      },
    },
  },
  {
    'caliguIa/zendiagram.nvim',
    opts = {},
    keys = {
      {
        '<leader>m',
        function()
          require('zendiagram').open()
        end,
        mode = { 'n' },
        desc = 'Float diagnostics',
      },
    },
  },
}
