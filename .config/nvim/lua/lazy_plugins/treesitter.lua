local function setup()
  local ts_au = vim.api.nvim_create_augroup('TsAu', { clear = true })

  require('nvim-treesitter').install({
    'asm',
    'awk',
    'bash',
    'bibtex',
    'c',
    'cmake',
    'cpp',
    'css',
    'csv',
    'diff',
    'dot',
    'gitcommit',
    'git_config',
    'git_rebase',
    'gpg',
    'graphql',
    'html',
    'htmldjango',
    'http',
    'ispc',
    'java',
    'javascript',
    'jinja',
    'jinja_inline',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'matlab',
    'nginx',
    'nm',
    'n.so',
    'passwd',
    'pem',
    'puppet',
    'python',
    'regex',
    'rust',
    'sql',
    'ssh_config',
    'strace',
    'tmux',
    'toml',
    'tsv',
    'vimdoc',
    'yaml',
    'zig',
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = ts_au,
    pattern = { '*' },
    callback = function(args)
      local ft = args['match']
      if not vim.tbl_contains(require('nvim-treesitter').get_installed(), ft) then
        if vim.tbl_contains(require('nvim-treesitter').get_available(), ft) then
          require('nvim-treesitter').install({ ft })
          vim.treesitter.start()
        end
      end
    end,
  })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'm-demare/hlargs.nvim',
      'David-Kunz/treesitter-unit',
      'cohama/lexima.vim',
    },
    lazy = false,
    build = ':TSUpdate',
    config = setup,
    branch = 'main',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    branch = 'main',
    event = 'VeryLazy',
    config = {
      select = {
        lookahead = true,
      },
    },
    keys = {
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
    config = function()
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
  {
    'daliusd/incr.nvim',
    opts = {
      incr_key = '<M-k>', -- increment selection key
      decr_key = '<M-j>', -- decrement selection key
    },
    -- event = 'VeryLazy',
  },
}
