local nest = require('nest')

nest.applyKeymaps({
	{ mode = 'nv', {
		-- Remove silent from ; : mapping, so that : shows up in command mode
		{ ';', ':' , options = { silent = false }},
		{ ':', ';' },
		-- Tabularize
		{ '<Leader>t', ':Tabularize /', options = { silent = false }},
	}},
	{ mode = 'ti', {
		{ 'jj', '<c-\\><c-n>' },
	}},
	{ mode = 'n', {
		-- remove search highlight
		{ '<space>', '<Cmd>nohlsearch<cr>', options = { silent = true }},

		-- move between buffers
		{ '<C-l>', '<Cmd>bnext<cr>' },
		{ '<C-j>', '<Cmd>bprev<cr>' },
		{ '<C-k>', '<Cmd>b#<cr>' },

		-- next error
		{ '<C-N>', '<Cmd>cn<cr>' },
		{ '<C-@><C-N>', '<Cmd>cN<cr>' },

		-- undo
		{ '<F5>', '<Cmd>GundoToggle<cr>' },

		-- fzf
		{ '<leader>', {
			{ 'pb', '<cmd>lua require("fzf-lua").buffers()<cr>' },
			{ 'pp', '<cmd>lua require("fzf-lua").files()<cr>' },
			{ 'pt', '<cmd>lua require("fzf-lua").loclist()<cr>' },
			{ 'pg', '<cmd>lua require("fzf-lua").grep()<cr>' },
		}},

		-- multipage editing
		{ '<leader>ef', '<cmd>vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>',
			options = { silent = true }
		},

		-- open init.vim
		{ '<leader>ve', '<cmd>vsplit $MYVIMRC<cr>G'},
	}},
	{ mode = 'c', {
		options = { silent = false },
		{ '<C-a>',  '<Home>' },
		{ '<C-b>',  '<Left>' },
		{ '<C-f>',  '<Right>' },
		{ '<C-d>',  '<Delete>' },
		{ '<M-b>',  '<S-Left>' },
		{ '<M-f>',  '<S-Right>' },
		{ '<M-d>',  '<S-right><Delete>' },
		{ '<Esc>b', '<S-Left>' },
		{ '<Esc>f', '<S-Right>' },
		{ '<Esc>d', '<S-right><Delete>' },
		{ '<C-g>',  '<C-c>' },
	}},

	-- magma
	{ mode = 'n', {
		options = { silent = true },
		{ '<leader>r',  "nvim_exec('MagmaEvaluateOperator', v:true)" , options = { expr = true }},
		{ '<leader>rr', '<cmd>MagmaEvaluateLine<CR>' },
		{ '<leader>ro', '<cmd>MagmaShowOutput<CR>' },
		{ '<leader>re', '<cmd>MagmaReevaluateCell<CR>' },
		{ '<leader>rd', '<cmd>MagmaDelete<CR>' },
		{ '<leader>ri', '<cmd>MagmaInit<CR>' },
		{ '<leader>rs', '<cmd>MagmaSave<CR>' },
		{ '<leader>rl', '<cmd>MagmaLoad<CR>' },
	}},
	{ mode = 'x', {
		options = { silent = true },
		{ '<leader>r',  ':<C-u>MagmaEvaluateVisual<CR>' },
	}},

	-- David-Kunz/treesitter-unit
	{ mode = 'xo', {
		{ 'iu', ':lua require"treesitter-unit".select()<CR>'},
		{ 'au', ':lua require"treesitter-unit".select(true)<CR>'},
	}},
	
	-- Iron
	{ mode = 'v', {
		{'<leader>c', "<cmd>lua require('iron').core.visual_send()<cr>"},
	}},
	{ mode = 'n', {
		{'<leader>c', "<plug>(iron-send-motion)"},
	}},

	-- vsnip
	--[[ { mode = 'is', {
		{'<Tab>',   "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'",   options = {expr = true}},
		{'<S-Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", options = {expr = true}},
	}}, ]]
})
