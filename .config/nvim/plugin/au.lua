
local misc = vim.api.nvim_create_augroup("Misc", {clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = misc,
  pattern = 'plugins.lua',
  callback = function()
    require('packer').compile()
    dump('compiled packer')
  end
})

-- highligh on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = misc,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350, on_visual = true })
  end,
})

-- syntax ranges
vim.api.nvim_create_autocmd('FileType', {
  group = misc,
  pattern = {'html.javascript', 'html', 'js', 'javascript'},
  callback = function()
    vim.cmd([[
    call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'SpecialComment')
    call SyntaxRange#Include('<script>', '</script>', 'javascript', 'SpecialComment')
  ]])
  end
})

-- jinja
vim.api.nvim_create_autocmd('FileType', {
  group = misc,
  pattern = {'html.javascript', 'html', 'js', 'javascript'},
  callback = function()
    if vim.o.filetype:match('.jinja$') then
      return
    end
    local regex = vim.regex([=[{%.*%}\|{{.*}}]=])
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do
      if regex:match_str(line) then
        vim.o.filetype = vim.o.filetype .. '.jinja'
        return
      end
    end
  end
})


local ftypes = vim.api.nvim_create_augroup("ftypes", {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  group = ftypes,
  pattern = { 'yaml' ,'lua' },
  callback = function()
    vim.api.nvim_buf_set_option(0, 'ts', 2)
    vim.api.nvim_buf_set_option(0, 'sts', 2)
    vim.api.nvim_buf_set_option(0, 'sw', 2)
    vim.api.nvim_buf_set_option(0, 'expandtab', true)
    vim.api.nvim_win_set_option(0, 'number', true)
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = ftypes,
  pattern = 'python',
  callback = function()
    vim.api.nvim_buf_set_option(0, 'ts', 4)
    vim.api.nvim_buf_set_option(0, 'sts', 4)
    vim.api.nvim_buf_set_option(0, 'sw', 4)
    vim.api.nvim_buf_set_option(0, 'expandtab', true)
    vim.api.nvim_buf_set_option(0, 'textwidth', 120)
    vim.api.nvim_win_set_option(0, 'number', true)
    vim.api.nvim_set_hl(
      0,
      '@sql',
      { bg='#282828' }
    )
  end
})


vim.api.nvim_create_autocmd('BufRead', {
  group = ftypes,
  pattern = '*.py',
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  end
})


--[[ local magma = vim.api.nvim_create_augroup("magma", {clear = true})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group = magma,
  pattern = '*.jupyter',
  callback = 'MyMagmaInit',
})
vim.api.nvim_create_autocmd('BufWrite', {
  group = magma,
  pattern = '*.jupyter',
  callback = function()
    vim.cmd('MagmaSave')
  end
}) ]]

-- iron
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = misc,
  pattern = '*.jupyter',
  callback = function()
    require('iron.core').repl_for('python')
  end
})
