local tsj = require('treesj')
local tsj_utils = require('treesj.langs.utils')

local python_presets = {
  both = {
  },
  join = {
    space_in_brackets = false,
    last_separator = false,
  },
  split = {
    last_separator = true,
  },
}
local langs = {
  python = {
    set = tsj_utils.set_preset_for_list(python_presets),
    dictionary = tsj_utils.set_preset_for_dict(python_presets),
    list = tsj_utils.set_preset_for_list(python_presets),
    parameters = tsj_utils.set_preset_for_list(python_presets),
    argument_list = tsj_utils.set_preset_for_list(python_presets),
    tuple = tsj_utils.set_preset_for_list(python_presets),
  }
}

tsj.setup({
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 320,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,
  langs = langs,
})

vim.keymap.set('n', '<leader>ss', function() tsj.toggle() end, { noremap = true })
