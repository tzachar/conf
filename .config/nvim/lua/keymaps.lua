local nest = require('nest')

nest.applyKeymaps({
  {
    mode = 'nv',
    {'<C-b>', '<cmd>pop<cr>'},
  },
  {
    mode = 'nv',
    {
      -- Remove silent from ; : mapping, so that : shows up in command mode
      { ';', ':', options = { silent = false } },
      { ':', ';' },
      -- Tabularize
      { '<Leader>t', ':Tabularize /', options = { silent = false } },
    },
  },
  { mode = 'ti', {
    { 'jj', '<c-\\><c-n>' },
    { '<C-c>', '<c-\\><c-n>' },
  } },
  {
    mode = 'n',
    {
      -- when moving to next search, center and open folds
      { 'n', 'nzzzv', options = { noremap = true, silent = true } },
      -- remove search highlight
      { '<space>', '<Cmd>nohlsearch<cr>', options = { silent = true } },

      -- move between buffers
      { '<C-l>', '<Cmd>bnext<cr>' },
      { '<C-j>', '<Cmd>bprev<cr>' },
      { '<C-k>', '<Cmd>b#<cr>' },

      -- next error
      { '<C-N>', '<Cmd>cn<cr>' },
      { '<C-@><C-N>', '<Cmd>cN<cr>' },

      -- undo
      { '<F5>', '<Cmd>MundoToggle<cr>' },

      -- fzf
      { '<leader>', {
        { 'pb', '<cmd>lua require("fzf-lua").buffers()<cr>' },
        { 'pp', '<cmd>lua require("fzf-lua").files()<cr>' },
        { 'pt', '<cmd>lua require("fzf-lua").loclist()<cr>' },
        { 'pg', '<cmd>lua require("fzf-lua").grep()<cr>' },
      } },

      -- multipage editing
      { '<leader>ef', '<cmd>vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>', options = { silent = true } },

      -- open init.vim
      { '<leader>ve', '<cmd>vsplit $MYVIMRC<cr>G' },

      -- swap ts node under cursor
      { '<leader>gs', '<cmd>ISwapNodeWithRight<cr>' },
      { '<leader>gS', '<cmd>ISwapNodeWithLeft<cr>' },
    },
  },
  { mode = 'c', {
    options = { silent = false },
    { '<C-a>', '<Home>' },
    { '<C-b>', '<Left>' },
    { '<C-f>', '<Right>' },
    { '<C-d>', '<Delete>' },
    { '<M-b>', '<S-Left>' },
    { '<M-f>', '<S-Right>' },
    { '<M-d>', '<S-right><Delete>' },
    { '<Esc>b', '<S-Left>' },
    { '<Esc>f', '<S-Right>' },
    { '<Esc>d', '<S-right><Delete>' },
    { '<C-g>', '<C-c>' },
  } },

  -- magma
  --[[ { mode = 'n', {
    options = { silent = true },
    { '<leader>r', "nvim_exec('MagmaEvaluateOperator', v:true)", options = { expr = true } },
    { '<leader>rr', '<cmd>MagmaEvaluateLine<CR>' },
    { '<leader>ro', '<cmd>MagmaShowOutput<CR>' },
    { '<leader>re', '<cmd>MagmaReevaluateCell<CR>' },
    { '<leader>rd', '<cmd>MagmaDelete<CR>' },
    { '<leader>ri', '<cmd>MagmaInit<CR>' },
    { '<leader>rs', '<cmd>MagmaSave<CR>' },
    { '<leader>rl', '<cmd>MagmaLoad<CR>' },
    { '<leader>rq', '<cmd>noautocmd MagmaEnterOutput<CR>' },
  } },
  { mode = 'x', {
    options = { silent = true },
    { '<leader>r', ':<C-u>MagmaEvaluateVisual<CR>' },
  } }, ]]

  -- David-Kunz/treesitter-unit
  { mode = 'xo', {
    { 'iu', ':lua require"treesitter-unit".select()<CR>' },
    { 'au', ':lua require"treesitter-unit".select(true)<CR>' },
  } },

  -- Iron
  { mode = 'v', {
    { '<leader>c', "<cmd>lua require('iron').core.visual_send()<cr>" },
  } },
  { mode = 'n', {
    { '<leader>c', '<plug>(iron-send-motion)' },
    { '<leader>rq', '<cmd>IronFocus<cr>' },
  } },

  -- neogen documentation
  { mode = 'n', {
    {'<leader>nf', "<cmd>lua require('neogen').generate({ type = 'func'  })<cr>" },
    {'<leader>nc', "<cmd>lua require('neogen').generate({ type = 'class' })<cr>" },
    {'<leader>nt', "<cmd>lua require('neogen').generate({ type = 'type' })<cr>" },
  } },

  { mode = 'n', {
    {'<leader>xx', "<cmd>TroubleToggle<cr>" },
    {'<leader>xw', "<cmd>TroubleToggle workspace_diagnostics<cr>" },
    {'<leader>xd', "<cmd>TroubleToggle document_diagnostics<cr>" },
    {'<leader>xq', "<cmd>TroubleToggle quickfix<cr>" },
    {'<leader>xl', "<cmd>loclist<cr>" },
  } },


  -- debugprint
  { mode = 'n', {
    { '<leader>d', function()
      return require('debugprint').debugprint()
    end, options = {expr = true} },
    { '<leader>D', function()
      return require('debugprint').debugprint({ above = true })
    end, options = {expr = true} },
    { '<leader>vd', function()
      return require('debugprint').debugprint({ variable = true })
    end, options = {expr = true} },
    { '<leader>vD', function()
      return require('debugprint').debugprint({ variable = true, above = true })
    end, options = {expr = true} },
  } },

  -- dial
  { mode = 'n', {
    {'<C-a>', require("dial.map").inc_normal(), options = {noremap = true} },
    {'<C-x>', require("dial.map").dec_normal(), options = {noremap = true} },
    {'+', require("dial.map").inc_normal(), options = {noremap = true} },
    {'-', require("dial.map").dec_normal(), options = {noremap = true} },
  } },
  { mode = 'v', {
    {'<C-a>', require("dial.map").inc_visual(), options = {noremap = true} },
    {'<C-x>', require("dial.map").dec_visual(), options = {noremap = true} },
    -- these are buggy for now!
    -- {'g<C-a>', require("dial.map").inc_gvisual(), options = {noremap = true} },
    -- {'g<C-x>', require("dial.map").dec_gvisual(), options = {noremap = true} },
  } },

  -- /query-secretary
  { mode = 'n', {
    {'<leader>z', function() require("query-secretary").query_window_initiate() end, options = {noremap = true} },
  } },
})
