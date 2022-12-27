return {
  { 'neovim/nvim-lspconfig' },
  -- update language servers
  {
    'williamboman/mason.nvim',
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = "williamboman/mason.nvim",
  },
  -- ls progress
  { 'j-hui/fidget.nvim' },

  { "onsails/lspkind-nvim" },
}
