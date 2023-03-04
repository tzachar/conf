require('kanagawa').setup({
  undercurl = true, -- enable undercurls
  overrides = function(colors)
    return {
      TSVariable = { fg = 'wheat' },
    }
  end,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        }
      }
    }
  },
})

-- this must be setup in init.vim for some reason
-- vim.cmd('colorscheme kanagawa')
