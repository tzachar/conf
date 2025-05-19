local function setup()
  local smooth_colors = {
    Smooth1 = '#A10100',
    Smooth2 = '#DA1F05',
    Smooth3 = '#F33C04',
    Smooth4 = '#FE650D',
    Smooth5 = '#FFC11F',
    Smooth6 = '#FFF75D',
  }

  for name, fg in pairs(smooth_colors) do
    vim.api.nvim_set_hl(0, name, { fg = fg })
  end

  require('smoothcursor').setup({
    autostart = true,
    flyin_effect = 'top',
    cursor = '', -- cursor shape (need nerd font)
    intervals = 35, -- tick interval
    linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
    type = 'default', -- define cursor movement calculate function, "default" or "exp" (exponential).
    fancy = {
      enable = true, -- enable fancy mode
      head = { cursor = '▷', texthl = 'SmoothCursor', linehl = nil },
      body = {
        --[[ { cursor = "", texthl = "SmoothCursorRed" },
      { cursor = "", texthl = "SmoothCursorOrange" },
      { cursor = "●", texthl = "SmoothCursorYellow" },
      { cursor = "●", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" }, ]]
        { cursor = '', texthl = 'Smooth1' },
        { cursor = '', texthl = 'Smooth2' },
        { cursor = '●', texthl = 'Smooth3' },
        { cursor = '•', texthl = 'Smooth4' },
        { cursor = '.', texthl = 'Smooth5' },
        { cursor = '.', texthl = 'Smooth6' },
      },
      tail = { cursor = nil, texthl = 'SmoothCursor' },
    },
    disable_float_win = true,
    priority = 20000, -- set marker priority
    speed = 25, -- max is 100 to stick to your current position
    texthl = 'SmoothCursor', -- highlight group, default is { bg = nil, fg = "#FFD400" }
    threshold = 3,
    timeout = 3000,
    disabled_filetypes = { 'cmd' },
  })
end

return {
  {
    'gen740/SmoothCursor.nvim',
    config = setup,
  },
}
