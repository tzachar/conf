local function setup()
  require('treesj').setup({
    use_default_keymaps = false,

    -- Node with syntax error will not be formatted
    check_syntax_error = true,

    -- If line after join will be longer than max value,
    -- node will not be formatted
    max_join_length = 1000,

    -- hold|start|end:
    -- hold - cursor follows the node/place on which it was called
    -- start - cursor jumps to the first symbol of the node being formatted
    -- end - cursor jumps to the last symbol of the node being formatted
    cursor_behavior = 'hold',

    -- Notify about possible problems or not
    notify = true,
    -- langs = langs,
    dot_repeat = true,
  })
end

return {
  {
    'Wansmer/treesj',
    keys = {
      {
        '<leader>ss',
        function()
          require('treesj').toggle()
        end,
        noremap = true,
      },
    },
    config = setup,
  },
} -- tree sj
