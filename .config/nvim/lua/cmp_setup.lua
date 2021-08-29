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
})

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
	calc = "[calc]",
}

local compare_priority = function(entry1, entry2)
	if not entry1.source.name == 'cmp_tabnine' then
		return false
	elseif not entry2.source.name == 'cmp_tabnine' then
		return true
	end

	if not entry1.completion_item.priority then
		return false
	elseif not entry2.completion_item.priority then
		return true
	else
		return (entry1.completion_item.priority > entry2.completion_item.priority)
	end
end

cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noselect,noinsert',
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
			compare.offset,
			compare.exact,
			compare.score,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		}
	},


	-- You must set mapping.
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
			else
				fallback()
			end
		end,

	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
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
	sources = {
		{ name = 'cmp_tabnine' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'emoji' },
		{ name = 'calc' },
	},
}

