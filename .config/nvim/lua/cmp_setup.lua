local lspkind = require('lspkind')
local cmp = require('cmp')
local compare = require('cmp.config.compare')
local types = require('cmp.types')
local tabnine = require('cmp_tabnine.config')

tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	priority = 5000;
	show_prediction_strength = true;
	run_on_every_keystroke = true;
	-- snippet_placeholder = '';
})

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
	calc = "[Calc]",
	treesitter = "[TS]",
	fuzzy_buffer = "[FZ]",
	fuzzy_path = "[FZ]",
}

local compare_priority = function(entry1, entry2)
	if entry1.source.name == 'cmp_tabnine' and entry2.source.name == 'cmp_tabnine' then
		if not entry1.completion_item.priority then
			return false
		elseif not entry2.completion_item.priority then
			return true
		else
			return (entry1.completion_item.priority > entry2.completion_item.priority)
		end
	end

	if entry1.source.name == 'cmp_tabnine' and entry2.source.name ~= 'cmp_tabnine' then
		return true
	elseif entry1.source.name ~= 'cmp_tabnine' and entry2.source.name == 'cmp_tabnine' then
		return false
	else
		return nil
	end
end

cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
		end
	},
	completion = {
		-- completeopt = 'menu,menuone,noselect,noinsert',
		-- completeopt = 'menu,menuone,noinsert',
		autocomplete = {types.cmp.TriggerEvent.InsertEnter, types.cmp.TriggerEvent.TextChanged},
		keyword_length = 1,
	},
	confirmation = {
		default_behavior = cmp.ConfirmBehavior.Replace,
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			compare_priority,
			require('cmp_fuzzy_buffer.compare'),
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		}
	},


	-- You must set mapping.
	mapping = {
		['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
		['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),{ 'i', 'c' }),
		['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
		}),
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
		['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.symbolic(vim_item.kind, {with_text = false})
			local menu = source_mapping[entry.source.name] or ('[' .. entry.source.name .. ']')
			if entry.source.name == 'cmp_tabnine' then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. ' ' .. menu
				end
				vim_item.kind = ''
			end
			vim_item.menu = menu
			return vim_item
		end
	},

	-- You should specify your *installed* sources.
	sources = cmp.config.sources({
		{
			name = 'fuzzy_buffer',
			options = {
				get_bufnrs = function()
					local bufs = {}
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
						if buftype ~= 'nofile' and buftype ~= 'prompt' then
							bufs[#bufs + 1] = buf
						end
					end
					return bufs
				end
			},
		},
		{ name = 'cmp_tabnine' },
		{ name = 'vsnip' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		-- { name = 'treesitter' },
		-- { name = 'buffer' },
		-- { name = 'path' },
		{ name = 'emoji' },
		{ name = 'calc' },
		{ name = 'fuzzy_path'},
	}),

	preselect = cmp.PreselectMode.None,

	experimental = {
		ghost_text = {
			hl_group = 'Comment',
		},
	},
}

cmp.setup.cmdline('/', {
	sources = cmp.config.sources({
		{ name = 'fuzzy_buffer', options = {
			get_bufnrs = function()
				return { vim.api.nvim_get_current_buf() }
			end,
		} }
	}
	)
})

cmp.setup.cmdline('?', {
	sources = cmp.config.sources({
		{ name = 'fuzzy_buffer', options = {
			get_bufnrs = function()
				return { vim.api.nvim_get_current_buf() }
			end,

		} }
	}
	)
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'fuzzy_path' }
	}, {
			{ name = 'cmdline' }
		})
})
