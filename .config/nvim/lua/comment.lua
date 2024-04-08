local function yank_and_comment(options)
  local start_line = options.line1
  local end_line = options.line2
  local m = vim.fn.mode()
    if m == 'v' or m == 'V' or m == '\22' then -- <C-V>
      start_line = vim.fn.getpos("'<")[2]
      end_line = vim.fn.getpos("'>")[2]
  end

  local original_text = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  require('vim._comment').toggle_lines(
    start_line,
    end_line,
    vim.api.nvim_win_get_cursor(0)
  )
  vim.fn.setreg('', original_text)
  vim.fn.setreg('+', original_text)
end

vim.api.nvim_create_user_command('YankAndComment', yank_and_comment, { range = true })
vim.keymap.set('n', 'gcy', "<cmd>YankAndComment<cr>", { desc = 'Toggle and yank comment line' })
vim.keymap.set('v', 'gcy', ":YankAndComment<cr><esc>", { desc = 'Toggle and yank comment line' })
