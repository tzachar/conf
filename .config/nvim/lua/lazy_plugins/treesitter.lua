return {
  {
    'arborist-ts/arborist.nvim',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'arborist-ts/arborist.nvim',
    },
    branch = 'main',
    event = 'VeryLazy',
    opts = {
      select = {
        lookahead = true,
      },
    },
    keys = {
      {
        '<leader>a',
        function()
          require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
        end,
        mode = { 'n' },
        desc = 'swam next',
      },
      {
        '<leader>A',
        function()
          require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
        end,
        mode = { 'n' },
        desc = 'swam prev',
      },
      {
        'af',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
      },
      {
        'if',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
      },
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
      },
    },
  },
  {
    'm-demare/hlargs.nvim',
    event = 'VeryLazy',
    opts = function()
      require('hlargs').setup({
        disable = function(_, bufnr)
          if vim.b.semantic_tokens then
            return true
          end
          local clients = (vim.lsp.get_clients or vim.lsp.get_clients)({ bufnr = bufnr })
          for _, c in pairs(clients) do
            if c.name ~= 'null-ls' and c:supports_method('textDocument/semanticTokens/full', 0) then
              vim.b.semantic_tokens = true
              return vim.b.semantic_tokens
            end
          end
        end,
      })
    end,
  },
  {
    'cohama/lexima.vim',
  },
  {
    'David-Kunz/treesitter-unit',
    event = 'VeryLazy',
  },
}
