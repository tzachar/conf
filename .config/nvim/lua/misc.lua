-- iron conf
require('nrpattern').setup()

local iron = require("iron")

iron.core.set_config{
	preferred = {
		python = "ipython",
	},
	memory_management = 'singleton',
}


-- this is for compe

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--  return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
 -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
 --   return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


function add_ignore_type()
	local line = vim.fn.getline('.')
	local ignore_decl = ' # type: ignore'
	local pos = vim.api.nvim_win_get_cursor(0)
	local row = pos[1] - 1
	if string.sub(line, -15, -1) == ignore_decl then
		vim.api.nvim_buf_set_text(0, row, #line - #ignore_decl, row, #line, {})
	else
		vim.api.nvim_buf_set_text(0, row, #line, row, #line, {ignore_decl})
	end
end

function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end
