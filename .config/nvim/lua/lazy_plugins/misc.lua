return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      -- load	lualine
      require('lualine').setup({
        options = {
          globalstatus = false,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(mode)
                return vim.go.paste == true and mode .. ' (paste)' or mode
              end,
            },
          },
        },
      })
    end,
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-refactor', dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
  {
    'nvim-treesitter/playground',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = { 'TSPlaygroundToggle' },
  },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({
        file_types = { 'python', 'cpp', 'lua' },
      })
    end,
  },
  { 'RRethy/nvim-treesitter-textsubjects', dependencies = 'nvim-treesitter/nvim-treesitter' },

  -- documentation
  {
    'danymat/neogen',
    config = function()
      require('neogen').setup({
        enabled = true,
        languages = {
          lua = {},
          python = {
            template = {
              annotation_convention = 'google_docstrings',
            },
          },
        },
      })
    end,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = { 'Neogen' },
  },

  -- {
  --   'echasnovski/mini.cursorword',
  --   version = false,
  --   config = function()
  --     require('mini.cursorword').setup()
  --     vim.api.nvim_set_hl(
  --       0,
  --       'MiniCursorword',
  --       { link = 'TSDefinition' }
  --     )
  --     vim.cmd([[hi! MiniCursorwordCurrent gui=NONE guifg=NONE guibg=NONE]])
  --     -- vim.api.nvim_set_hl(
  --     --   0,
  --     --   'MiniCursorwordCurrent',
  --     --   {
  --     --     fg = nil,
  --     --     bg = nil,
  --     --     nocombine = true,
  --     --   }
  --     -- )
  --   end
  -- },
  --
  -- zephyr-nvim dependencies nvim-treesitter
  -- use {'glepnir/zephyr-nvim', branch = 'main', dependencies = 'nvim-treesitter/nvim-treesitter'}
  -- use({ 'folke/tokyonight.nvim' })
  { 'rebelot/kanagawa.nvim' },

  {
    'simnalamburt/vim-mundo',
    cmd = { 'MundoToggle' },
  },
  {
    'mileszs/ack.vim',
    cmd = { 'Ack' },
  },

  -- jump to last place
  { 'farmergreg/vim-lastplace' },

  -- use({ '~/fzf', build = './install --all' })
  -- -- use { 'junegunn/fzf.vim', dependencies = '~/fzf' }
  -- use({ 'ibhagwan/fzf-lua', dependencies = {
  --   'vijaymarupudi/nvim-fzf',
  -- } })
  {
    'vim-scripts/ExtractMatches',
    cmd = {
      'GrepToReg',
      'GrepRangeToReg',
      'YankMatches',
      'YankUniqueMatches',
      'PrintMatches',
      'PrintUniqueMatches',
      'SubstituteAndYank',
      'SubstituteAndYankUnique',
      'PutMatches',
      'PutUniqueMatches',
    },
    dependencies = { 'vim-scripts/ingo-library' },
  },

  -- c cpp stuff
  { 'vim-scripts/FSwitch', ft = { 'c', 'cpp' } },
  { 'vim-scripts/headerguard', ft = { 'c', 'cpp' } },
  { 'DeonPoncini/includefixer', ft = { 'c', 'cpp' } },

  { 'tpope/vim-repeat' },
  { 'jamessan/vim-gnupg', ft = { 'gnupg' } },

  { 'lervag/vimtex', ft = { 'tex', 'latex' } },
  { 'sjl/splice.vim', cmd = 'SpliceInit' },

  { 'vimoutliner/vimoutliner', ft = 'otl' },
  { 'vim-scripts/dbext.vim', ft = 'sql', enabled = false },

  -- use 'rking/ag.vim'
  { 'jelera/vim-javascript-syntax', ft = { 'js', 'javascript', 'html', 'html.javascript' } },
  -- use 'machakann/vim-highlightedyank'
  { 'alvan/vim-closetag', ft = { 'html', 'html.javascript' } },
  { 'wellle/targets.vim' },
  {
    'tommcdo/vim-exchange',
    keys = { 'cx', nil, mode = { 'n', 'v' } },
  },
  -- { "vim-scripts/TextTransform" },

  -- python formatter
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'godlygeek/tabular', cmd = 'Tabularize' },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- indend-guides setup
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = false,
      })
    end,
  },

  -- add cmd utils as vim commands
  { 'tpope/vim-eunuch', cmd = {
    'Delete',
    'Unlink',
    'Remove',
    'Move',
    'Rename',
    'Chmod',
    'Mkdir',
    'Cfind',
    'Lfind',
    'Clocate',
    'Llocate',
    'SudoEdit',
    'SudoWrite',
  } },

  { 'Numkil/ag.nvim', cmd = {
    'Ag',
    'AgAdd',
    'LAg',
    'LAgAdd',
  } },

  -- show mappings
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end,
  },

  -- syntax ranges
  { 'vim-scripts/SyntaxRange', ft = { 'html.javascript', 'html', 'js', 'javascript' } },

  -- align on character
  {
    'tommcdo/vim-lion',
    keys = {
      { 'gl', nil, desc = 'align right on character', mode = { 'n', 'v' } },
      { 'gL', nil, desc = 'align left on character', mode = { 'n', 'v' } },
    },
  },

  { 'ntpeters/vim-better-whitespace' },

  -- git
  { 'tpope/vim-fugitive', lazy = true, cmd = { 'G', 'Git' } },

  -- quickfix magic
  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    ft = { 'qf' },
  },

  -- change commentstring based on location in file
  { 'JoosepAlviste/nvim-ts-context-commentstring' },

  -- dev icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      -- load devicons
      require('nvim-web-devicons').setup({
        default = true,
      })
    end,
  },

  { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } },

  { 'David-Kunz/treesitter-unit', lazy = true },

  -- for keymappings
  { 'LionC/nest.nvim' },

  -- user defined text objects
  { 'kana/vim-textobj-user' },
  { 'Julian/vim-textobj-variable-segment', dependencies = { 'kana/vim-textobj-user' } },

  -- trouble
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup({})
    end,
    cmd = { 'TroubleToggle' },
  },

  -- matchit
  { 'andymass/vim-matchup' },

  -- graphql support
  { 'jparise/vim-graphql', ft = { 'grapgql', 'gql' } },

  -- nvim 0.8 smart rename
  {
    'smjonas/inc-rename.nvim',
    lazy = true,
    cmd = 'IncRename',
    keys = {
      {
        'gt',
        function()
          return ':IncRename ' .. vim.fn.expand('<cword>')
        end,
        expr = true,
        desc = 'Incremental rename',
      },
    },
    config = function()
      require('inc_rename').setup()
    end,
  },

  -- diagnostic lines
  {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
  },

  -- swap ts nodes
  {
    'mizlan/iswap.nvim',
    config = function()
      require('iswap').setup()
    end,
    keys = {
      -- swap ts node under cursor
      {
        '<leader>gs',
        function()
          require('iswap').iswap_node_with('right')
        end,
      },
      {
        '<leader>gS',
        function()
          require('iswap').iswap_node_with('left')
        end,
      },
    },
  },

  -- debug prints
  {
    'andrewferrier/debugprint.nvim',
    lazy = true,
    config = function()
      require('debugprint').setup({
        create_keymaps = false,
      })
    end,
  },

  -- live command preview
  {
    'smjonas/live-command.nvim',
    config = function()
      -- live command setup
      require('live-command').setup({
        commands = {
          Norm = { cmd = 'norm' },
        },
      })
    end,
  },

  -- auto list:
  {
    'gaoDean/autolist.nvim',
    event = { 'InsertEnter' },
    ft = {
      'markdown',
      'text',
      'tex',
      'plaintex',
    },
    config = function()
      local autolist = require('autolist')
      autolist.setup()
      autolist.create_mapping_hook('i', '<cr>', autolist.new)
      autolist.create_mapping_hook('i', '<tab>', autolist.indent)
      autolist.create_mapping_hook('i', '<s-tab>', autolist.indent, '<c-d>')
      autolist.create_mapping_hook('n', 'dd', autolist.force_recalculate)
      autolist.create_mapping_hook('n', 'o', autolist.new)
      autolist.create_mapping_hook('n', 'O', autolist.new_before)
      autolist.create_mapping_hook('n', '>>', autolist.indent)
      autolist.create_mapping_hook('n', '<<', autolist.indent)
      autolist.create_mapping_hook('n', '<c-r>', autolist.force_recalculate)
      autolist.create_mapping_hook('n', '<leader>x', autolist.invert_entry, '')
    end,
  },

  -- inc dec
  {
    'monaqa/dial.nvim',
    lazy = true,
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.integer.alias.binary,
          augend.constant.alias.bool,
          augend.constant.new({ elements = { 'True', 'False' } }),
        },
      })
    end,
    keys = {
      { '<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      { '<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      { '+', '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      { '-', '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      { '<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'v' },
      { '<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'v' },
      -- these are buggy for now!
      -- {'g<C-a>', require("dial.map").inc_gvisual(), options = {noremap = true} },
      -- {'g<C-x>', require("dial.map").dec_gvisual(), options = {noremap = true} },
    },
  },

  -- ts query builder
  {
    'ziontee113/query-secretary',
    lazy = true,
    keys = {
      {
        '<leader>z',
        function()
          require('query-secretary').query_window_initiate()
        end,
        noremap = true,
        desc = 'query secretary',
      },
    },
  },

  -- ssr
  {
    'cshuaimin/ssr.nvim',
    module = 'ssr',
    -- Calling setup is optional.
    keys = {
      {
        '<leader>sr',
        function()
          require('ssr').open()
        end,
        noremap = true,
        mode = { 'n', 'x' },
      },
    },
    config = function()
      require('ssr').setup({
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = 'q',
          next_match = 'n',
          prev_match = 'N',
          replace_all = '<leader><cr>',
        },
      })
    end,
  },

  -- sqlite lua
  { 'kkharji/sqlite.lua', lazy = true },

  -- jinja support
  {
    'HiPhish/jinja.vim',
    ft = { 'js', 'javascript', 'html', 'html.javascript' },
  },

  {
    'aduros/ai.vim',
    lazy = true,
    cmd = { 'AI' },
  },
  {
    'jackMort/ChatGPT.nvim',
    config = function()
      require('chatgpt').setup({
        -- optional configuration
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    cmd = {
      'ChatGPT',
      'ChatGPTActAs',
      'ChatGPTEditWithInstructions',
    },
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('ultimate-autopair').setup({
        --Config goes here
        fastwarp = {
          enable = true,
          map = '<M-]>',
          cmap = '<M-]>',
          rmap = '<M-[>',
          rcmap = '<M-[>',
          fallback = nil,
        },
        extensions = {
          { 'suround', { '"', "'", '{', '}', '[', ']', '(', ')' } },
        },
      })
    end,
  },
}
