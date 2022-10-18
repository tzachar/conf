local vim = vim
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.api.nvim_command('packadd packer.nvim')
end

vim.cmd('autocmd BufWritePost plugins.lua PackerCompile') -- Auto compile when there are changes in plugins.lua
return require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')

    -- faster plugins loader
    -- use {'lewis6991/impatient.nvim', rocks = 'mpack'}
    use({ 'lewis6991/impatient.nvim' })

    use('neovim/nvim-lspconfig')
    -- update language servers
    use({
      'williamboman/mason.nvim',
      requires = "neovim/nvim-lspconfig",
    })
    use({
      'williamboman/mason-lspconfig.nvim',
      requires = "williamboman/mason.nvim",
    })
    use({ 'ojroques/nvim-lspfuzzy', branch = 'main' })
    -- ls progress
    use('j-hui/fidget.nvim')

    use('onsails/lspkind-nvim')
    use('hrsh7th/nvim-cmp') --completion
    use({ 'hrsh7th/cmp-nvim-lsp', requires = 'onsails/lspkind-nvim' })
    use('hrsh7th/cmp-buffer') --completion
    use('hrsh7th/cmp-calc') --completion
    use('hrsh7th/cmp-path') --completion
    use('hrsh7th/cmp-emoji') --completion
    use('hrsh7th/cmp-nvim-lua') --completion
    use('hrsh7th/cmp-cmdline') --completion
    use({ 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' })
    use('ray-x/cmp-treesitter')
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/vim-vsnip')
    use('hrsh7th/vim-vsnip-integ')
    use('hrsh7th/cmp-nvim-lsp-signature-help')
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use({ 'tzachar/fuzzy.nvim', requires = { 'nvim-telescope/telescope-fzf-native.nvim' } })
    use({ 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } })
    use({ 'tzachar/cmp-fuzzy-path', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } })

    use({ 'nvim-lualine/lualine.nvim' })
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter' })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' })
    use({ 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter' })
    use({ 'RRethy/nvim-treesitter-textsubjects', requires = 'nvim-treesitter/nvim-treesitter' })

    -- documentation
    use {
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
      requires = "nvim-treesitter/nvim-treesitter"
    }

    -- zephyr-nvim requires nvim-treesitter
    -- use {'glepnir/zephyr-nvim', branch = 'main', requires = 'nvim-treesitter/nvim-treesitter'}
    -- use({ 'folke/tokyonight.nvim' })
    use({ 'rebelot/kanagawa.nvim' })

    use({ 'simnalamburt/vim-mundo' })
    use({ 'mileszs/ack.vim', opt = true, cmd = { 'Ack' } })

    -- jump to last place
    use('farmergreg/vim-lastplace')

    use('jeetsukumaran/vim-buffergator')

    use({ '~/fzf', run = './install --all' })
    -- use { 'junegunn/fzf.vim', requires = '~/fzf' }
    use({ 'ibhagwan/fzf-lua', requires = {
      'vijaymarupudi/nvim-fzf',
    } })

    use({
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
    })

    -- c cpp stuff
    use({ 'vim-scripts/FSwitch', ft = { 'c', 'cpp' } })
    use({ 'vim-scripts/headerguard', ft = { 'c', 'cpp' } })
    use({ 'DeonPoncini/includefixer', ft = { 'c', 'cpp' } })

    use('tpope/vim-repeat')
    use('jamessan/vim-gnupg')

    use({ 'lervag/vimtex', ft = { 'tex', 'latex' } })
    use({ 'sjl/splice.vim', cmd = 'SpliceInit' })
    use('wellle/targets.vim')

    -- use 'jeetsukumaran/vim-commentary'
    use('b3nj5m1n/kommentary')

    use('vim-scripts/ingo-library')
    use('vim-scripts/TextTransform')
    use({ 'vimoutliner/vimoutliner', ft = 'otl' })
    use('tommcdo/vim-exchange')
    use({ 'vim-scripts/dbext.vim', ft = 'sql' })

    -- use('tpope/vim-surround')
    use ({'kylechui/nvim-surround', })
    -- use 'rking/ag.vim'
    use({ 'jelera/vim-javascript-syntax', ft = { 'js', 'javascript', 'html', 'html.javascript' } })
    -- use 'machakann/vim-highlightedyank'
    use({ 'alvan/vim-closetag', ft = { 'html', 'html.javascript' } })
    -- show changes in vcs
    use('airblade/vim-gitgutter')
    -- use 'mhinz/vim-signify'

    -- python formatter
    use({ 'google/yapf', rtp = 'plugins/vim', ft = 'python' })

    use({ 'Vimjas/vim-python-pep8-indent', ft = 'python' })

    use('godlygeek/tabular')
    -- use('nathanaelkane/vim-indent-guides')
    use "lukas-reineke/indent-blankline.nvim"

    -- add cmd utils as vim commands
    use({ 'tpope/vim-eunuch', cmd = {
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
    } })

    use({ 'Numkil/ag.nvim', opt = true, cmd = {
      'Ag',
      'AgAdd',
      'LAg',
      'LAgAdd',
    } })

    -- show mappings
    use({
      'folke/which-key.nvim',
    })

    -- syntax ranges
    use('vim-scripts/SyntaxRange')

    -- align on character
    use('tommcdo/vim-lion')

    use('ntpeters/vim-better-whitespace')

    -- git
    use('tpope/vim-fugitive')

    -- iron, repr integration
    use('hkupty/iron.nvim')

    -- quickfix magic
    use('kevinhwang91/nvim-bqf')

    -- change commentstring based on location in file
    use('JoosepAlviste/nvim-ts-context-commentstring')

    -- dev icons
    use('kyazdani42/nvim-web-devicons')

    -- magma:
    -- use({
    --   'dccsillag/magma-nvim',
    --   run = ':UpdateRemotePlugins',
    --   -- config = 'vim.cmd [[UpdateRemotePlugins]]',
    -- })

    use({ 'dstein64/vim-startuptime' })

    use({ 'David-Kunz/treesitter-unit' })

    -- for keymappings
    use({ 'LionC/nest.nvim' })

    -- user defined text objects
    use({ 'kana/vim-textobj-user' })
    use({ 'Julian/vim-textobj-variable-segment', requires = { 'kana/vim-textobj-user' } })

    -- endwise
    use('RRethy/nvim-treesitter-endwise')

    -- null-ls
    use({'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' }})

    -- trouble
    use ({'folke/trouble.nvim', requires = {'kyazdani42/nvim-web-devicons'},
      config = function()
        require("trouble").setup {}
      end,})

    -- matchit
    use "andymass/vim-matchup"

    -- graphql support
    use "jparise/vim-graphql"

    -- nvim 0.8 smart rename
    use "smjonas/inc-rename.nvim"

    -- diagnostic lines
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

    -- swap ts nodes
    use 'mizlan/iswap.nvim'

    -- debug prints
    use({
      "andrewferrier/debugprint.nvim",
      config = function()
        require("debugprint").setup({
          create_keymaps = false,
        })
      end,
    })

    --[[ use ({
      "AckslD/nvim-trevJ.lua",
      config = function()
        require("trevj").setup()
      end,
    })
 ]]
    -- highlight var under cursor
    -- use "RRethy/vim-illuminate"

    -- smooth cursor
    use "gen740/SmoothCursor.nvim"

    -- live command preview
    use "smjonas/live-command.nvim"

    -- auto list:
    use "gaoDean/autolist.nvim"

    -- inc dec
    -- use('AndrewRadev/switch.vim')
    -- use('zegervdv/nrpattern.nvim')
    use('monaqa/dial.nvim')

  end,

  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  },
})
