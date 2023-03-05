local aaaa = 3
require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
          fg = 'wheat',
        },
        syn = {
          identifier = 'wheat',
        },
      },
    },
  },
})

-- this must be setup in init.vim for some reason
-- vim.cmd('colorscheme kanagawa')
