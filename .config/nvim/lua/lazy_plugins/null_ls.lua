return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        -- debug = true,
        debounce = 2000,
        sources = {
          -- null_ls.builtins.formatting.yapf,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell,
          -- null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
        },
      })
    end,
  },
}
