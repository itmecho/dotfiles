return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({ flavour = 'macchiato' })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
      })

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/playground' },
  { 'lukas-reineke/indent-blankline.nvim' },
  {
    'nvim-tree/nvim-tree.lua',
    config = true,
    opts = {
      hijack_netrw = false,
      view = {
        width = 40,
      },
    },
    keys = {
      { '<leader>po', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle project drawer' },
    },
    lazy = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_a = {},
        lualine_b = { 'filetype' },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'diff' },
        lualine_y = { 'branch' },
        lualine_z = { "os.date('%H:%M')" },
      },
    },
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'lewis6991/gitsigns.nvim' },
  { 'numToStr/Comment.nvim', config = true },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_lua').load({ paths = { '../itmecho/snippets' } })
    end,
  },
}
