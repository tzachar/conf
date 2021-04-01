-- iron conf
require('nrpattern').setup()

local iron = require("iron")

iron.core.set_config{
	preferred = {
		python = "ipython",
	},
	memory_management = 'singleton',
}


function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

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


-- should be called with luado
function add_ignore_type(line, linenr)
	local ignore_decl = ' # type: ignore'
	if #(vim.lsp.diagnostic.get_line_diagnostics(0, linenr)) > 0 then
		vim.api.nvim_buf_set_text(0, linenr, #line, linenr, #line, {ignore_decl})
	elseif string.sub(line, -15, -1) == ignore_decl then
		vim.api.nvim_buf_set_text(0, linenr, #line - #ignore_decl, linenr, #line, {})
	end
end

-- function add_ignore_type(linestart, lineend)
-- 	if linestart ~= nil then
-- 		dump('no line')
-- 	end
-- 	local ignore_decl = ' # type: ignore'
-- 	local row = nil
-- 	if linestart == nil then
-- 		local pos = vim.api.nvim_win_get_cursor(0)
-- 		linestart = pos[1] - 1
-- 		lineend = linestart + 1
-- 	end
-- 	local lines = vim.api.nvim_buf_get_lines(0, linestart, lineend, false)
-- 	for i, line in ipairs(lines) do
-- 		local lineno = linestart + i - 1
-- 		if #(vim.lsp.diagnostic.get_line_diagnostics(0, lineno)) > 0 then
-- 			vim.api.nvim_buf_set_text(0, lineno, #line, lineno, #line, {ignore_decl})
-- 		elseif string.sub(line, -15, -1) == ignore_decl then
-- 			vim.api.nvim_buf_set_text(0, lineno, #line - #ignore_decl, lineno, #line, {})
-- 		-- else
-- 		-- 	vim.api.nvim_buf_set_text(0, lineno, #line, lineno, #line, {ignore_decl})
-- 		end
-- 	end
-- end

