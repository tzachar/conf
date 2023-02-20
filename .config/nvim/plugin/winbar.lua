local class = require('middleclass')
local lspkind = require('lspkind')
local Winbar = class('Winbar')

function Winbar:initialize()
  -- self.au_group = vim.api.nvim_create_augroup("Winbar", {clear = true})
  -- vim.api.nvim_create_autocmd('CursorHold,CursorHoldI', {
  --   group = self.au_group,
  --   pattern = { '*.py' ,'*.lua', '*.js', },
  --   callback = function()
  --     self:update()
  --   end,
  -- })
end

function Winbar:transform(line)
  line = line:gsub('%s*[%[%(%{]*%s*$', '')
  local is_class = line:match('%s*class')
  local is_def = line:match('%s*def')
  local kind = ''
  if is_class then
    kind = lspkind.symbolic('Class')
  elseif is_def then
    kind = lspkind.symbolic('Function')
  end
  line = line:gsub('class%s*', '')
  line = line:gsub('def%s*', '')
  line = line:gsub(':$', '')
  return kind .. ' ' .. line
end

function Winbar:update()
  local winbar = require('nvim-treesitter').statusline({
    indicator_size = 100,
    type_patterns = { 'class', 'function', 'method' },
    -- transform_fn = function(line) return line:gsub('%s*[%[%(%{]*%s*$', '') end,
    transform_fn = function(line)
      return self:transform(line)
    end,
    separator = ' -> ',
  })
  if winbar == nil or #winbar == 0 then
    winbar = 'there be dragons'
  end
  vim.wo.winbar = winbar
end

return Winbar:new()
