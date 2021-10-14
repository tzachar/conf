local lspkind = require('lspkind')
local cmp = require('cmp')
local compare = require('cmp.config.compare')
local types = require('cmp.types')
local tabnine = require('cmp_tabnine.config')

-- add highligh groups
vim.cmd[[
highlight CmpItemMenu guifg=wheat
highlight CmpItemAbbr guifg=#868272
highlight CmpItemAbbrMatch guifg=wheat gui=bold gui=underline
highlight CmpItemAbbrMatchFuzzy guifg=wheat gui=bold gui=underline
]]

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
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
		['jj'] = function(fallback)
      if cmp.visible() then
				require('cmp').close()
			end
			fallback()
		end,
		['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
		['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.symbolic(vim_item.kind, {with_text = false})
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
		{ name = 'vsnip' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'treesitter' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'emoji' },
		{ name = 'calc' },
	},

	preselect = cmp.PreselectMode.None,

	experimental = {
		ghost_text = {
			hl_group = 'Comment',
		},
	},
}

