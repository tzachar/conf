return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'tzachar/local-highlight.nvim',
    },
    config = function()
      -- load	lualine
      require('lualine').setup({
        extensions = {
          'lazy',
          'mason',
        },
        options = {
          globalstatus = false,
          -- theme = 'tokyonight',
        },
        sections = {
          lualine_y = {
            'progress',
            function()
              return string.format('match count: %2d', require('local-highlight').match_count())
            end,
          },
        },
      })
    end,
  },
  {
    'tzachar/local-highlight.nvim',
    opts = {
      file_types = { 'python', 'cpp', 'lua', 'rust', 'c', 'cpp', 'javascript', 'sh' },
    },
  },
  -- documentation
  {
    'danymat/neogen',
    enabled = true,
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

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require('tokyonight').setup({
        style = 'night',
        transparent = false,
      })
      vim.cmd('colorscheme tokyonight')
    end,
  },
  {
    'xiantang/darcula-dark.nvim',
    enabled = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      vim.cmd('colorscheme darcula-dark')
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    config = function()
      require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        colors = {
          theme = {
            all = {
              ui = {
                bg = 'black',
                bg_gutter = 'none',
                fg = 'wheat',
              },
              syn = {
                identifier = 'wheat',
              },
            },
          },
        },
      })
      vim.cmd('colorscheme kanagawa')
    end,
    build = function()
      require('kanagawa').compile()
    end,
  },
  {
    "jiaoshijie/undotree",
    opts = {},
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
      { "<F5>", "<cmd>lua require('undotree').toggle()<cr>" },
    },
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
  {
    'vim-scripts/FSwitch',
    ft = { 'c', 'cpp' },
  },
  {
    'vim-scripts/headerguard',
    ft = { 'c', 'cpp' },
  },
  {
    'DeonPoncini/includefixer',
    ft = { 'c', 'cpp' },
  },

  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  { 'jamessan/vim-gnupg', ft = { 'gnupg' } },

  { 'lervag/vimtex', ft = { 'tex', 'latex' } },
  { 'sjl/splice.vim', cmd = 'SpliceInit' },

  { 'vimoutliner/vimoutliner', ft = 'otl' },
  { 'vim-scripts/dbext.vim', ft = 'sql', enabled = false },

  -- use 'rking/ag.vim'
  { 'jelera/vim-javascript-syntax', ft = { 'js', 'javascript', 'html', 'html.javascript' } },
  -- use 'machakann/vim-highlightedyank'
  { 'alvan/vim-closetag', ft = { 'html', 'html.javascript' } },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
  {
    'tommcdo/vim-exchange',
    keys = { 'cx', nil, mode = { 'n', 'v' } },
  },
  -- { "vim-scripts/TextTransform" },

  -- python formatter
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
    event = 'VeryLazy',
  },
  { 'godlygeek/tabular', cmd = 'Tabularize' },

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

  -- show mappings
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end,
    event = 'VeryLazy',
  },

  -- syntax ranges
  {
    'vim-scripts/SyntaxRange',
    ft = { 'html.javascript', 'html', 'js', 'javascript' },
  },

  -- align on character
  {
    'tommcdo/vim-lion',
    keys = {
      { 'gl', nil, desc = 'align right on character', mode = { 'n', 'v' } },
      { 'gL', nil, desc = 'align left on character', mode = { 'n', 'v' } },
    },
  },

  -- highlight whitespace at eol
  {
    'ntpeters/vim-better-whitespace',
    event = 'VeryLazy',
  },

  -- strip white space from eol as you type
  {
    'lewis6991/spaceless.nvim',
    event = 'VeryLazy',
  },

  -- git
  { 'tpope/vim-fugitive', lazy = true, cmd = { 'G', 'Git' } },

  -- quickfix magic
  {
    'kevinhwang91/nvim-bqf',
    ft = { 'qf' },
  },

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

  -- for keymappings
  { 'LionC/nest.nvim' },

  -- user defined text objects
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
  },
  {
    'Julian/vim-textobj-variable-segment',
    dependencies = { 'kana/vim-textobj-user' },
    event = 'VeryLazy',
  },

  -- trouble
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup({})
    end,
    cmd = { 'Trouble' },
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xd',
        '<cmd>Trouble todo toggle<cr>',
        desc = 'TODO (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  -- matchit
  {
    'andymass/vim-matchup',
    enabled = true,
    config = function()
      vim.g.matchup_delim_stopline = 30000
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },

  -- graphql support
  { 'jparise/vim-graphql', ft = { 'grapgql', 'gql' } },

  -- nvim 0.8 smart rename
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    opt = {
      input_buffer_type = 'snacks',
    },
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
  },

  -- debug prints
  {
    'andrewferrier/debugprint.nvim',
    version = '*',
    opts = {
      keymaps = {
        normal = {
          plain_below = 'g?p',
          plain_above = 'g?P',
          variable_below = 'g?v',
          variable_above = 'g?V',
          variable_below_alwaysprompt = '',
          variable_above_alwaysprompt = '',
          surround_plain = 'g?sp',
          surround_variable = 'g?sv',
          surround_variable_alwaysprompt = '',
          textobj_below = 'g?o',
          textobj_above = 'g?O',
          textobj_surround = 'g?so',
          toggle_comment_debug_prints = '',
          delete_debug_prints = '',
        },
        insert = {
          plain = '<C-G>p',
          variable = '<C-G>v',
        },
        visual = {
          variable_below = 'g?v',
          variable_above = 'g?V',
        },
      },
      commands = {
        toggle_comment_debug_prints = 'ToggleCommentDebugPrints',
        delete_debug_prints = 'DeleteDebugPrints',
        reset_debug_prints_counter = 'ResetDebugPrintsCounter',
        search_debug_prints = 'SearchDebugPrints',
      },
    },
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
    event = 'VeryLazy',
  },

  -- inc dec
  {
    'monaqa/dial.nvim',
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
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gnormal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gnormal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'normal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'normal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        '+',
        function()
          require('dial.map').manipulate('increment', 'normal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        '-',
        function()
          require('dial.map').manipulate('decrement', 'normal')
        end,
        noremap = true,
        mode = 'n',
      },
      {
        '<C-a>',
        function()
          require('dial.map').manipulate('increment', 'visual')
        end,
        noremap = true,
        mode = 'x',
      },
      {
        '<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'visual')
        end,
        noremap = true,
        mode = 'x',
      },
      {
        'g<C-a>',
        function()
          require('dial.map').manipulate('increment', 'gvisual')
        end,
        noremap = true,
        mode = 'x',
      },
      {
        'g<C-x>',
        function()
          require('dial.map').manipulate('decrement', 'gvisual')
        end,
        noremap = true,
        mode = 'x',
      },
    },
  },

  -- ts query builder
  {
    'ziontee113/query-secretary',
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
  -- { 'kkharji/sqlite.lua', lazy = true },
  --
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePrompt' },
        fast_wrap = {
          map = '<M-e>',
          end_key = '$',
        },
      })
    end,
  },
  {
    'tzachar/highlight-undo.nvim',
    -- event = 'VeryLazy',
    opts = {},
  },
  {
    'https://github.com/Hubro/nvim-splitrun',
    opts = {},
    cmd = {
      'Splitrun',
      'SplitrunNew',
    },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    -- for this to work under windows terminal, add the following to the json
    -- config:
    -- "actions": [
    --   {
    --     "keys": "ctrl+enter",
    --     "command": { "action": "sendInput", "input": "\u001b[13;5u" }
    --   },
    --   {
    --     "keys": "shift+enter",
    --     "command": { "action": "sendInput", "input": "\u001b[13;2u" }
    --   }
    -- ]
    'ysmb-wtsg/in-and-out.nvim',
    -- keys = { '<C-CR>', nil, mode = { 'i' } },
    config = function()
      vim.keymap.set('i', '<C-CR>', function()
        require('in-and-out').in_and_out()
      end, { noremap = true })
    end,
  },
  {
    'svban/YankAssassin.nvim',
    config = function()
      require('YankAssassin').setup({
        auto = true, -- if auto is true, autocmds are used. Whenever y is used anywhere, the cursor doesn't move to start
      })
      -- Optional Mappings
      vim.keymap.set({ 'x', 'n' }, 'gy', '<Plug>(YADefault)', { silent = true })
      vim.keymap.set({ 'x', 'n' }, '<leader>y', '<Plug>(YANoMove)', { silent = true })
    end,
  },
  -- {
  --   "Isrothy/neominimap.nvim",
  --   enabled = true,
  --   lazy = false,
  --   init = function()
  --     vim.opt.wrap = false -- Recommended
  --     vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
  --     vim.g.neominimap = {
  --       auto_enable = true,
  --       exclude_filetypes = { "help" },
  --       buf_filter = function(bufnr)
  --         local line_count = vim.api.nvim_buf_line_count(bufnr)
  --         return line_count < 4096 * 4
  --       end,
  --     }
  --   end,
  -- },
  -- prettify quickfix
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  -- markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'codecompanion' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
  -- stay-in-place.nvim is a Neovim plugin that prevent the cursor from moving when using shift and filter actions.
  -- keeps visual selection after applying operator
  {
    'gbprod/stay-in-place.nvim',
    opts = {
      set_keymaps = true,
      preserve_visual_selection = true,
    },
  },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
  -- fix file indentations
  { 'tpope/vim-sleuth' },
  -- {
  --   "dmtrKovalenko/fff.nvim",
  --   build = "cargo build --release",
  --   -- or if you are using nixos
  --   -- build = "nix run .#release",
  --   opts = {
  --     -- pass here all the options
  --   },
  --   keys = {
  --     {
  --       "ff", -- try it if you didn't it is a banger keybinding for a picker
  --       function()
  --         require("fff").find_files()
  --       end,
  --       desc = "FFFind FFFiles",
  --     },
  --   },
  -- }
}
