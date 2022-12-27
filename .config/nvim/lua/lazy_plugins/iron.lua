local function setup()
  local iron = require("iron.core")

  iron.setup {
    config = {
      -- If iron should expose `<plug>(...)` mappings for the plugins
      should_map_plug = false,
      -- Whether a repl should be discarded or not
      scratch_repl = false,
      -- Your repl definitions come here
      scope = require("iron.scope").path_based,
      repl_definition = {
        sh = {
          command = {"zsh"}
        },
        python = require("iron.fts.python").ipython,
      },
      -- repl_open_cmd = require('iron.view').curry.right(60),
      repl_open_cmd = 'rightbelow vsplit',
      buflisted = false,
    },
    -- Iron doesn't set keymaps by default anymore. Set them here
    -- or use `should_map_plug = true` and map from you vim files
    keymaps = {
      send_motion = "<leader>r",
      visual_send = "<leader>r",
      send_file = "<leader>rf",
      send_line = "<leader>rr",
      send_mark = "<leader>rm",
      mark_motion = "<leader>rc",
      mark_visual = "<leader>rc",
      remove_mark = "<leader>rd",
      cr = "<leader>r<cr>",
      interrupt = "<leader>r<leader>",
      exit = "<leader>rq",
      clear = "<leader>rl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
      italic = false
    }
  }

end

local au_group = vim.api.nvim_create_augroup("Iron", {clear = true})
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = au_group,
  pattern = '*.jupyter',
  callback = function()
    require('iron.core').repl_for('python')
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  group = au_group,
  pattern = '*.jupyter',
  callback = function()
    require('iron.core').hide_repl()
  end
})


return{
  {
    "hkupty/iron.nvim",
    lazy = true,
    config = setup,
    cmd = {
      "IronRepl",
      "IronReplHere",
      "IronRestart",
      "IronSend",
      "IronFocus",
      "IronHide",
      "IronWatch",
      "IronAttach",
    }
  },
}
