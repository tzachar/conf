local vim = vim
local install_path = vim.fn.stdpath('data') ..  '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.api.nvim_command 'packadd packer.nvim'
end

--[[
inspected_buffers = {}
function limit_by_line_count(max_lines)
	local fname = vim.fn.expand("%:p")
	if fname ~= nil then
		return true
	end
	local cache = inspected_buffers[fname]
	if cache ~= nil then
		return cache
	end

	max_lines = max_lines or 1000
	local lines = 0
	for _ in io.lines(fname) do
		lines = lines + 1
		if lines > max_lines then
			break
		end
	end
	inspected_buffers[fname] = (lines <= max_lines)
	return inspected_buffers[fname]
end
 ]]

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
return require("packer").startup({
  function(use)
    use 'wbthomason/packer.nvim'

		-- faster plugins loader
		use {'lewis6991/impatient.nvim', rocks = 'mpack'}

		use "neovim/nvim-lspconfig"
		-- update language servers
		use 'williamboman/nvim-lsp-installer'
		use {'ojroques/nvim-lspfuzzy', branch = 'main'}

		use "onsails/lspkind-nvim"
		use "hrsh7th/nvim-cmp" --completion
		use {"hrsh7th/cmp-nvim-lsp", requires = 'onsails/lspkind-nvim' }
		use "hrsh7th/cmp-buffer" --completion
		use "hrsh7th/cmp-calc" --completion
		use "hrsh7th/cmp-path" --completion
		use "hrsh7th/cmp-emoji" --completion
		use "hrsh7th/cmp-nvim-lua" --completion
		use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
		use 'ray-x/cmp-treesitter'
		use 'hrsh7th/cmp-vsnip'
		use 'hrsh7th/vim-vsnip'
		use 'hrsh7th/vim-vsnip-integ'

		--[[ use {
			'glepnir/galaxyline.nvim',
			branch = 'main',
		} ]]
		use { 'shadmansaleh/lualine.nvim' }
		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter'}
		use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter'}
		use { 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter'}
		use { 'RRethy/nvim-treesitter-textsubjects', requires = 'nvim-treesitter/nvim-treesitter'}
		-- use { 'nvim-treesitter/nvim-tree-docs', requires = {
		-- 		'nvim-treesitter/nvim-treesitter',
		-- 		'Olical/aniseed',
		-- 		'bakpakin/fennel.vim'
		-- 	},
		-- }
		-- use {'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter'}
		-- use {'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter', cond = limit_by_line_count, opt = true}
		-- documentation
		use { 'kkoomen/vim-doge', run = ':call doge#install()'}

		-- zephyr-nvim requires nvim-treesitter
		-- use {'glepnir/zephyr-nvim', branch = 'main', requires = 'nvim-treesitter/nvim-treesitter'}
		use { 'folke/tokyonight.nvim' }

		use 'zegervdv/nrpattern.nvim'

		use { 'simnalamburt/vim-mundo' }
		use { 'mileszs/ack.vim', opt = true, cmd = {'Ack'}}

		-- jump to last place
		use 'farmergreg/vim-lastplace'

		use 'jeetsukumaran/vim-buffergator'

		use 'ggandor/lightspeed.nvim'

		use { '~/fzf', run = './install --all' }
		-- use { 'junegunn/fzf.vim', requires = '~/fzf' }
		use { 'ibhagwan/fzf-lua',
			requires = {
				'vijaymarupudi/nvim-fzf',
			}
		}

		use {
			'vim-scripts/ExtractMatches',
			cmd = {
				"GrepToReg",
				"GrepToReg",
				"GrepRangeToReg",
				"GrepRangeToReg",
				"YankMatches",
				"YankMatches",
				"YankMatches",
				"YankUniqueMatches",
				"YankUniqueMatches",
				"YankUniqueMatches",
				"PrintMatches",
				"PrintMatches",
				"PrintMatches",
				"PrintUniqueMatches",
				"PrintUniqueMatches",
				"PrintUniqueMatches",
				"SubstituteAndYank",
				"SubstituteAndYankUnique",
				"PutMatches",
				"PutMatches",
				"PutMatches",
				"PutUniqueMatches",
				"PutUniqueMatches",
				"PutUniqueMatches",
			}
		}

		-- c cpp stuff
		use { 'vim-scripts/FSwitch', ft = {'c', 'cpp'} }
		use { 'vim-scripts/headerguard', ft = {'c', 'cpp'} }
		use { 'DeonPoncini/includefixer', ft = {'c', 'cpp'} }

		use 'tpope/vim-repeat'
		use 'jamessan/vim-gnupg'

		use { 'lervag/vimtex', ft = {'tex', 'latex'} }
		use { 'sjl/splice.vim', cmd = 'SpliceInit' }
		use 'wellle/targets.vim'

		-- use 'jeetsukumaran/vim-commentary'
		use 'b3nj5m1n/kommentary'

		use 'vim-scripts/ingo-library'
		use 'vim-scripts/TextTransform'
		use { 'vimoutliner/vimoutliner', ft = 'otl' }
		use 'AndrewRadev/switch.vim'
		use 'tommcdo/vim-exchange'
		use { 'vim-scripts/dbext.vim', ft = 'sql' }
		use 'tpope/vim-surround'
		-- use 'rking/ag.vim'
		use { 'jelera/vim-javascript-syntax', ft = {'js', 'javascript', 'html', 'html.javascript'}}
		-- use 'machakann/vim-highlightedyank'
		use { 'alvan/vim-closetag', ft = { 'html' , 'html.javascript' }}
		-- show changes in vcs
		use 'mhinz/vim-signify'

		-- python formatter
		use {'google/yapf', rtp = 'plugins/vim', ft = 'python' }

		use { 'Vimjas/vim-python-pep8-indent', ft = 'python' }

		use 'godlygeek/tabular'
		use 'nathanaelkane/vim-indent-guides'

		-- add cmd utils as vim commands
		use { 'tpope/vim-eunuch', cmd = {
			"Delete",
			"Unlink",
			"Remove",
			"Move",
			"Rename",
			"Chmod",
			"Mkdir",
			"Cfind",
			"Lfind",
			"Clocate",
			"Llocate",
			"SudoEdit",
			"SudoWrite",
			}
		}

		use { 'Numkil/ag.nvim',
			opt = true,
			cmd = {
				'Ag', 'AgAdd', 'LAg', 'LAgAdd',
			}
		}

		-- show mappings
		use {
			"folke/which-key.nvim",
		}

		-- syntax ranges
		use 'vim-scripts/SyntaxRange'

		-- align on character
		use 'tommcdo/vim-lion'

		use 'ntpeters/vim-better-whitespace'

		-- if semshi does not work, you need to open a python file and
		-- then :UpdateRemotePlugins
		-- use {'numirias/semshi', run = ':UpdateRemotePlugins', ft = 'python'}

		-- git
		use 'tpope/vim-fugitive'

		-- iron, repr integration
		use 'hkupty/iron.nvim'

		-- quickfix magic
		use 'kevinhwang91/nvim-bqf'

		-- change commentstring based on location in file
		use 'JoosepAlviste/nvim-ts-context-commentstring'

		-- wildmenu
		use {
			'gelguy/wilder.nvim',
			requires = {
				{'nixprime/cpsm', run='./install.sh'},
				'romgrk/fzy-lua-native',
				'kyazdani42/nvim-web-devicons',
			}
		}

		-- magma:
		use {
			'dccsillag/magma-nvim',
			run = ':UpdateRemotePlugins',
			-- config = 'vim.cmd [[UpdateRemotePlugins]]',
		}

		use { 'dstein64/vim-startuptime' }

		use { 'David-Kunz/treesitter-unit' }

		-- for keymappings
		use { 'LionC/nest.nvim' }
	end,
	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
	}
	}
)
