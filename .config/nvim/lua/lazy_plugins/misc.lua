return {
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-refactor', dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/playground', dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'RRethy/nvim-treesitter-textsubjects', dependencies = 'nvim-treesitter/nvim-treesitter' },

  -- documentation
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {
        enabled = true,
        languages = {
          lua = {},
          python = {
            template = {
              annotation_convention = 'google_docstrings'
            }
          }
        }
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = {'Neogen'},
  },

  -- zephyr-nvim dependencies nvim-treesitter
  -- use {'glepnir/zephyr-nvim', branch = 'main', dependencies = 'nvim-treesitter/nvim-treesitter'}
  -- use({ 'folke/tokyonight.nvim' })
  { 'rebelot/kanagawa.nvim' },

  { 'simnalamburt/vim-mundo' },
  { 'mileszs/ack.vim', lazy = true, cmd = { 'Ack' } },

  -- jump to last place
  { "farmergreg/vim-lastplace" },

  -- use('jeetsukumaran/vim-buffergator')

  -- use({ '~/fzf', build = './install --all' })
  -- -- use { 'junegunn/fzf.vim', dependencies = '~/fzf' }
  -- use({ 'ibhagwan/fzf-lua', dependencies = {
  --   'vijaymarupudi/nvim-fzf',
  -- } })
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

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
    dependencies = { "vim-scripts/ingo-library" },
  },

  -- c cpp stuff
  { 'vim-scripts/FSwitch', ft = { 'c', 'cpp' } },
  { 'vim-scripts/headerguard', ft = { 'c', 'cpp' } },
  { 'DeonPoncini/includefixer', ft = { 'c', 'cpp' } },

  { "tpope/vim-repeat" },
  { "jamessan/vim-gnupg", ft = { 'gnupg' } },

  { 'lervag/vimtex', ft = { 'tex', 'latex' } },
  { 'sjl/splice.vim', cmd = 'SpliceInit' },

  { 'vimoutliner/vimoutliner', ft = 'otl' },
  { 'vim-scripts/dbext.vim', ft = 'sql' , enabled=false},

  -- use 'rking/ag.vim'
  { 'jelera/vim-javascript-syntax', ft = { 'js', 'javascript', 'html', 'html.javascript' } },
  -- use 'machakann/vim-highlightedyank'
  { 'alvan/vim-closetag', ft = { 'html', 'html.javascript' } },

  -- show changes in vcs
  { "airblade/vim-gitgutter" },
  { "wellle/targets.vim" },
  {
    "tommcdo/vim-exchange",
    keys = {'cx', nil, mode = {'n', 'v'}},
  },
  -- { "vim-scripts/TextTransform" },

  -- python formatter
  {
    'google/yapf',
    ft = 'python',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/plugins/vim")
    end
  },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'godlygeek/tabular', cmd = 'Tabularize'},
  { "lukas-reineke/indent-blankline.nvim" },

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
  { 'folke/which-key.nvim' },

  -- syntax ranges
  { "vim-scripts/SyntaxRange", ft = {'html.javascript', 'html', 'js', 'javascript'}},

  -- align on character
  {
    "tommcdo/vim-lion",
    keys = {
      {'gl', nil, desc = 'align right on character', mode = {'n', 'v'}},
      {'gL', nil, desc = 'align left on character', mode = {'n', 'v'}},
    },
  },

  { "ntpeters/vim-better-whitespace" },

  -- git
  { "tpope/vim-fugitive" , lazy = true, cmd = {'G', 'Git'}, },

  -- quickfix magic
  { "kevinhwang91/nvim-bqf", lazy=true,},

  -- change commentstring based on location in file
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- dev icons
  { "kyazdani42/nvim-web-devicons" },

  { 'dstein64/vim-startuptime', cmd = {'StartupTime'} },

  { 'David-Kunz/treesitter-unit', lazy=true},

  -- for keymappings
  { 'LionC/nest.nvim' },

  -- user defined text objects
  { 'kana/vim-textobj-user' },
  { 'Julian/vim-textobj-variable-segment', dependencies = { 'kana/vim-textobj-user' } },

  -- endwise
  { "RRethy/nvim-treesitter-endwise" },

  -- null-ls
  { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- trouble
  { 'folke/trouble.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("trouble").setup {}
    end, },

  -- matchit
  { "andymass/vim-matchup" },

  -- graphql support
  { "jparise/vim-graphql", ft = {'grapgql', 'gql'}},

  -- nvim 0.8 smart rename
  {
    "smjonas/inc-rename.nvim",
    lazy = true,
    cmd = 'IncRename',
    keys = {
      {'gt', function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, expr = true, desc = 'Incremental rename' },
    },
    config = function()
      require("inc_rename").setup()
    end
  },

  -- diagnostic lines
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
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
      { '<leader>gs', function()
        require('iswap').iswap_node_with('right')
      end },
      { '<leader>gS', function()
        require('iswap').iswap_node_with('left')
      end },
    },
  },

  -- debug prints
  {
    "andrewferrier/debugprint.nvim",
    lazy = true,
    config = function()
      require("debugprint").setup({
        create_keymaps = false,
      })
    end,
  },

  -- smooth cursor
  { "gen740/SmoothCursor.nvim" },

  -- live command preview
  { "smjonas/live-command.nvim" },

  -- auto list:
  { "gaoDean/autolist.nvim" },

  -- inc dec
  {
    'monaqa/dial.nvim',
    lazy = true,
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.integer.alias.binary,
          augend.constant.alias.bool,
          augend.constant.new{ elements = {"True", "False"} }
        },
      }
    end,
    keys = {
      {'<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      {'<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      {'+', '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      {'-', '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      {'<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'v' },
      {'<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'v' },
    -- these are buggy for now!
    -- {'g<C-a>', require("dial.map").inc_gvisual(), options = {noremap = true} },
    -- {'g<C-x>', require("dial.map").dec_gvisual(), options = {noremap = true} },
    },
  },

  -- ts query builder
  {
    "ziontee113/query-secretary",
    lazy = true,
    keys = {
      {'<leader>z', function() require("query-secretary").query_window_initiate() end, noremap = true, desc = 'query secretary' },
    },
  },

  -- ssr
  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    keys = {
        {'<leader>sr', function() require("ssr").open() end, noremap = true, mode = {'n', 'x'} },
    },
    config = function()
      require("ssr").setup {
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_all = "<leader><cr>",
        },
      }
    end
  },

  -- sqlite lua
  { 'kkharji/sqlite.lua', lazy=true },

  -- tre climber
  {
    'Dkendal/nvim-treeclimber',
    dependencies = 'rktjmp/lush.nvim',
    config = function()
      require('nvim-treeclimber').setup()
    end,
    enabled = false,
  },

  -- jinja support
  { "HiPhish/jinja.vim" },

  -- useless
  -- {
  --   'eandrju/cellular-automaton.nvim',
  --   cmd = {
  --     'CellularAutomaton',
  --   }
  -- },

  {
    "aduros/ai.vim",
    lazy = true,
    cmd = { 'AI' },
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        -- optional configuration
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    lazy = true,
    cmd = {
      'ChatGPT',
      'ChatGPTActAs',
      'ChatGPTEditWithInstructions',
    },
  },
  { "lewis6991/impatient.nvim" },
}
