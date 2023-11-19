local function yank_and_comment(options)
  local comment_api = require('Comment.api')
  local start_line = (options.line1 or vim.fn.line('.')) - 1
  local end_line = options.line2 or vim.fn.line('.')
  local original_text = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
  comment_api.comment.linewise.count(end_line - start_line)
  vim.fn.setreg('', original_text)
  vim.fn.setreg('+', original_text)
end

vim.api.nvim_create_user_command('YankAndComment', yank_and_comment, { range = true })

return {
  -- change commentstring based on location in file
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc<space>', '<Plug>(comment_toggle_linewise_current)', silent = true, desc = 'toggle line comment' },
      { 'gcy', '<cmd>YankAndComment<cr>', silent = true, desc = 'yank and comment' },
      { 'gcy', ':YankAndComment<cr>', silent = true, desc = 'yank and comment', mode = 'v' },
      { 'gc', nil, desc = 'Toggles the current line using linewise comment', mode = { 'n', 'v' } },
      { 'gb', nil, desc = 'Toggles the current line using linewise comment', mode = { 'n', 'v' } },
    },
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        mappings = { basic = true, extra = true },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
}
