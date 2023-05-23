local function mason_post_install(pkg, _)
  if pkg.name ~= 'python-lsp-server' then
    return
  end

  vim.notify('Restart and run :PylspInstall python-lsp-ruff', vim.log.levels.WARN)
end

return {
  { 'neovim/nvim-lspconfig' },
  -- update language servers
  {
    'williamboman/mason.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUninstall" },
    config = function()
      require("mason").setup()
      require("mason-registry"):on("package:install:success", vim.schedule_wrap(mason_post_install))
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = 'williamboman/mason.nvim',
  },
  -- ls progress
  { 'j-hui/fidget.nvim' },

  { 'onsails/lspkind-nvim' },
}
