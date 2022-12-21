require('lazy').setup({
  -- faster plugins loader
  -- use {'lewis6991/impatient.nvim', rocks = 'mpack'}
  -- { 'lewis6991/impatient.nvim' }

  { 'neovim/nvim-lspconfig' },
  -- update language servers
  {
    'williamboman/mason.nvim',
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = "williamboman/mason.nvim",
  },
  -- ls progress
  { 'j-hui/fidget.nvim' },

  { "onsails/lspkind-nvim" },
  { "hrsh7th/nvim-cmp" },
  { 'hrsh7th/cmp-nvim-lsp', dependencies = 'onsails/lspkind-nvim' },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-calc" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-emoji" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-cmdline" },
  { 'tzachar/cmp-tabnine', build = './install.sh', dependencies = 'hrsh7th/nvim-cmp' },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/vim-vsnip-integ" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "ray-x/cmp-treesitter" },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'tzachar/fuzzy.nvim', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' } },
  { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } },
  { 'tzachar/cmp-fuzzy-path', dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } },

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
      'GrepToReg',
      'GrepRangeToReg',
      'GrepRangeToReg',
      'YankMatches',
      'YankMatches',
      'YankMatches',
      'YankUniqueMatches',
      'YankUniqueMatches',
      'YankUniqueMatches',
      'PrintMatches',
      'PrintMatches',
      'PrintMatches',
      'PrintUniqueMatches',
      'PrintUniqueMatches',
      'PrintUniqueMatches',
      'SubstituteAndYank',
      'SubstituteAndYankUnique',
      'PutMatches',
      'PutMatches',
      'PutMatches',
      'PutUniqueMatches',
      'PutUniqueMatches',
      'PutUniqueMatches',
    },
  },

  -- c cpp stuff
  { 'vim-scripts/FSwitch', ft = { 'c', 'cpp' } },
  { 'vim-scripts/headerguard', ft = { 'c', 'cpp' } },
  { 'DeonPoncini/includefixer', ft = { 'c', 'cpp' } },

  { "tpope/vim-repeat" },
  { "jamessan/vim-gnupg", ft = { 'gnupg' } },

  { 'lervag/vimtex', ft = { 'tex', 'latex' } },
  { 'sjl/splice.vim', cmd = 'SpliceInit' },

  -- use 'jeetsukumaran/vim-commentary'
  { 'numToStr/Comment.nvim' },

  { 'vimoutliner/vimoutliner', ft = 'otl' },
  { 'vim-scripts/dbext.vim', ft = 'sql' , enabled=false},

  -- 'tpope/vim-surround',
  { 'kylechui/nvim-surround' },
  -- use 'rking/ag.vim'
  { 'jelera/vim-javascript-syntax', ft = { 'js', 'javascript', 'html', 'html.javascript' } },
  -- use 'machakann/vim-highlightedyank'
  { 'alvan/vim-closetag', ft = { 'html', 'html.javascript' } },

  -- show changes in vcs
  { "airblade/vim-gitgutter" },
  { "wellle/targets.vim" },
  { "tommcdo/vim-exchange" },
  { "vim-scripts/ingo-library" },
  { "vim-scripts/TextTransform" },

  -- python formatter
  { 'google/yapf', rtp = 'plugins/vim', ft = 'python' },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'godlygeek/tabular' },
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
  { "vim-scripts/SyntaxRange" },

  -- align on character
  { "tommcdo/vim-lion" },

  { "ntpeters/vim-better-whitespace" },

  -- git
  { "tpope/vim-fugitive" , cmd = {'G', 'Git'}, },

  -- iron, repr integration
  { "hkupty/iron.nvim", lazy=true},

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
  { "jparise/vim-graphql" },

  -- nvim 0.8 smart rename
  { "smjonas/inc-rename.nvim" },

  -- diagnostic lines
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  -- swap ts nodes
  { 'mizlan/iswap.nvim' },

  -- debug prints
  {
    "andrewferrier/debugprint.nvim",
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
  { 'monaqa/dial.nvim' },


  -- ts query builder
  { "ziontee113/query-secretary" },

  -- ssr
  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
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

  -- tree sj
  {'Wansmer/treesj' },

  -- useless
  -- {
  --   'eandrju/cellular-automaton.nvim',
  --   cmd = {
  --     'CellularAutomaton',
  --   }
  -- },

  { "aduros/ai.vim" },
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
  },
  { "lewis6991/impatient.nvim" },
})
