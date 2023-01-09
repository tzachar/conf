local function setup()
  local surround = require("nvim-surround.config")
  require("nvim-surround").setup({
    surrounds = {
      ["f"] = {
        add = function()
          local result = surround.get_input("Enter the function name: ")
          if result then
            return { { result .. "(" }, { ")" } }
          end
        end,
      }
    }
  })

  local surround_print = {
    lua = 'dump',
    python = 'print',
    js = 'console.log',
    html = 'console.log',
  }

  surround.buffer_setup({
    surrounds = {
      ["p"] = {
        add = function()
          local print = surround_print[vim.bo.filetype] or 'print'
          return { { print .. "(" }, { ")" } }
        end,
        find = function()
          local print = surround_print[vim.bo.filetype] or 'print'
          return surround.get_selection({pattern = print .. "%b()"})
        end,
        delete = function()
          local print = surround_print[vim.bo.filetype] or 'print'
          return surround.get_selections({char = "p", pattern = "^(" .. print .. "%()().-(%))()$"})
        end,
        change = {
          target = function()
            local print = surround_print[vim.bo.filetype] or 'print'
            return surround.get_selections({char = "p", pattern = "^(" .. print .. "%()().-(%))()$"})
          end
        },
      },
    }
  })
end


return {
  {
    'kylechui/nvim-surround',
    config = setup,
    keys = {
      { 'ys', nil, desc = 'surround', mode = {'n', 'v'} },
      { 'cs', nil, desc = 'surround', mode = {'n', 'v'} },
      { 'ds', nil, desc = 'surround', mode = {'n', 'v'} },
      { '<C-g>s', nil, desc = 'Insert mode surround', mode = 'i'},
      { 'S', nil, desc = 'Visual mode surround', mode = 'v'},
    },
  }
}

