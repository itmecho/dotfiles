local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup('plugins')
--[[
  use('wbthomason/packer.nvim')
  use({ 'catppuccin/nvim', as = 'catppuccin' })
  use({
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  })

 :q
 :q
 use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use('nvim-treesitter/nvim-treesitter-context')

  use('jose-elias-alvarez/null-ls.nvim')

  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
  use('nvim-telescope/telescope-file-browser.nvim')
  use('nvim-telescope/telescope-ui-select.nvim')

  use({ 'nvim-lualine/lualine.nvim', requires = { 'nvim-lua/lsp-status.nvim' } })

  use('tpope/vim-fugitive')

  use('nvim-tree/nvim-web-devicons')

  use('itmecho/neoterm.nvim')

  use({ 'nvim-neorg/neorg', requires = { 'folke/zen-mode.nvim' } })

  use('lukas-reineke/indent-blankline.nvim')

  if packer_bootstrap then
    require('packer').sync()
  end
end)
--]]
