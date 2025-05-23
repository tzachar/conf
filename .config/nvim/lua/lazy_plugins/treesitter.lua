local function setup()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    sync_install = false,
    ensure_installed = {
      'python',
      'c',
      'cpp',
      'json',
      'bash',
      'html',
      'css',
      'lua',
    },
    ignore_install = {},
    modules = {},

    indent = {
      enable = false,
      disable = { 'py', 'python' },
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      -- see https://github.com/nvim-treesitter/nvim-treesitter/issues/1573#issuecomment-2202945329
      additional_vim_regex_highlighting = { 'python' },
      disable = {
        -- "python",
      }, -- list of language that will be disabled
      custom_captures = { -- mapping of user defined captures to highlight groups
        -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = { -- mappings for incremental selection (visual mappings)
        -- init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
        node_incremental = '<M-k>', -- increment to the upper named parent
        scope_incremental = '<M-i>', -- increment to the upper scope (as defined in locals.scm)
        node_decremental = '<M-j>', -- decrement to the previous node
      },
    },
    textobjects = {
      enable = true,
      lsp_interop = {
        enable = true,
        --[[ peek_definition_code = {
          ["df"] = "@function.outer",
          ["dF"] = "@class.outer",
        }, ]]
      },
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },
  })

  local ask_install = {}
  function EnsureTSParserInstalled()
    local parsers = require('nvim-treesitter.parsers')
    local lang = parsers.get_buf_lang()
    if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
      vim.schedule_wrap(function()
        local res = vim.fn.confirm('Install treesitter parser for ' .. lang, '&Yes\n&No', 1)
        if res == 1 then
          vim.cmd('TSInstall ' .. lang)
        else
          ask_install[lang] = false
        end
      end)()
    end
  end

  local ts_au = vim.api.nvim_create_augroup('TsAu', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = ts_au,
    pattern = '*',
    callback = function()
      EnsureTSParserInstalled()
    end,
  })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'm-demare/hlargs.nvim',
      'David-Kunz/treesitter-unit',
      'cohama/lexima.vim',
    },
    build = ':TSUpdate',
    config = setup,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
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
}
