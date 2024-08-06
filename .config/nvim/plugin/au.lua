local misc = vim.api.nvim_create_augroup('Misc', { clear = true })

-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = misc,
--   pattern = 'plugins.lua',
--   callback = function()
--     require('packer').compile()
--     dump('compiled packer')
--   end
-- })
--
-- highligh on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = misc,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350, on_visual = true })
  end,
})

-- jinja
vim.api.nvim_create_autocmd('FileType', {
  group = misc,
  pattern = { 'html.javascript', 'html', 'js', 'javascript' },
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
  end,
})

local ftypes = vim.api.nvim_create_augroup('ftypes', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = ftypes,
  pattern = { 'yaml', 'lua' },
  callback = function()
    vim.api.nvim_set_option_value('ts', 2, {scope="local", buf=0})
    vim.api.nvim_set_option_value('sts', 2, {scope="local", buf=0})
    vim.api.nvim_set_option_value('sw', 2, {scope="local", buf=0})
    vim.api.nvim_set_option_value('expandtab', true, {scope="local", buf=0})
    vim.api.nvim_set_option_value('number', true, {scope="local", win=0})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = ftypes,
  pattern = 'python',
  callback = function()
    vim.api.nvim_set_option_value('ts', 4, {scope="local", buf=0})
    vim.api.nvim_set_option_value('sts', 4, {scope="local", buf=0})
    vim.api.nvim_set_option_value('sw', 4, {scope="local", buf=0})
    vim.api.nvim_set_option_value('expandtab', true, {scope="local", buf=0})
    vim.api.nvim_set_option_value('textwidth', 120, {scope="local", buf=0})
    vim.api.nvim_set_option_value('number', true, {scope="local", win=0})
    vim.api.nvim_set_hl(0, '@sql', { bg = '#282828' })
  end,
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

local filetypes = vim.api.nvim_create_augroup('FileTypes', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = filetypes,
  pattern = { 'cpp', 'h', 'c', 'cu', 'proto', 'hpp' },
  callback = function()
    vim.bo.cinoptions = ':0,p0,t0,l1,g0,(0,W8,m1 cinwords=if,else,while,do,for,switch,case'
    vim.bo.formatoptions = 'tcqrl'
    vim.bo.cinkeys = '0{,0},0),0#,!^F,o,O,e,:'
    vim.bo.cindent = true
    vim.g.showmatch = true
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetypes,
  pattern = { 'java' },
  callback = function()
    vim.cmd('ab <buffer> sop System.out.println')
    vim.bo.formatoptions = 'tcqr'
    vim.bo.cindent = true
    vim.bo.showmatch = true
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetypes,
  pattern = { 'html.javascript', 'html', 'js', 'javascript', 'json' },
  callback = function(args)
    if args.match == 'html' or args.match == 'html.javascript' then
      vim.cmd([[
        call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'SpecialComment')
        call SyntaxRange#Include('<script>', '</script>', 'javascript', 'SpecialComment')
      ]])
    end
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.textwidth = 10000
  end,
})

vim.api.nvim_create_autocmd('BufRead', {
  group = filetypes,
  pattern = { '*.jupyter' },
  callback = function()
    vim.bo.filetype = 'python'
  end,
})
