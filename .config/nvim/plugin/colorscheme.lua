local gitSigns = { change = '#6183bb', add = '#449dab', delete = '#914c54', conflict = '#bb7a61' }
require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  overrides = {
    GitGutterAddLineNR = { fg = gitSigns.add }, -- diff mode: Added line |diff.txt|
    GitGutterChangeLineNR = { fg = gitSigns.change }, -- diff mode: Changed line |diff.txt|
    GitGutterDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    GitGutterChangeDeleteLineNR = { fg = gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    TSVariable = { fg = 'wheat' },
  },
})

-- this must be setup in init.vim for some reason
-- vim.cmd('colorscheme kanagawa')
