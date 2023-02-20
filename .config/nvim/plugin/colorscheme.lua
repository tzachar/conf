require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  overrides = {
    TSVariable = { fg = 'wheat' },
  },
})

-- this must be setup in init.vim for some reason
-- vim.cmd('colorscheme kanagawa')
