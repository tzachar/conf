local install_path = vim.fn.stdpath('data') ..  '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
return require("packer").startup(
	function(use)
		use 'wbthomason/packer.nvim'

		use "neovim/nvim-lspconfig"
		-- update language servers
		use 'alexaandru/nvim-lspupdate'
		use {'ojroques/nvim-lspfuzzy', branch = 'main'}

		use "hrsh7th/nvim-compe" --completion
		use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}

		use 'vim-airline/vim-airline'
		use 'vim-airline/vim-airline-themes'

		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter'}
		use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter'}
		use {'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter'}

		-- zephyr-nvim requires nvim-treesitter
		use {'glepnir/zephyr-nvim', branch = 'main', requires = 'nvim-treesitter/nvim-treesitter'}

		use 'zegervdv/nrpattern.nvim'

		use { 'sjl/gundo.vim', opt = true, cmd = {'GundoToggle', 'GundoHide', 'GundoShow'}}
		use { 'mileszs/ack.vim', opt = true, cmd = {'Ack'}}

		-- jump to last place
		use 'farmergreg/vim-lastplace'

		use 'jeetsukumaran/vim-buffergator'

		use 'justinmk/vim-sneak'

		use { '~/fzf', run = './install --all' }
		use { 'junegunn/fzf.vim', requires = '~/fzf' }

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

		use 'jeetsukumaran/vim-commentary'

		use 'vim-scripts/ingo-library'
		use 'vim-scripts/TextTransform'
		use { 'vimoutliner/vimoutliner', ft = 'otl' }
		use 'AndrewRadev/switch.vim'
		use 'tommcdo/vim-exchange'
		use { 'vim-scripts/dbext.vim', ft = 'sql' }
		use 'tpope/vim-surround'
		use 'rking/ag.vim'
		use { 'jelera/vim-javascript-syntax', ft = {'js', 'javascript', 'html', 'html.javascript'}}
		use 'machakann/vim-highlightedyank'
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

		-- show mappings
		-- use 'liuchengxu/vim-which-key'

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

	end
)