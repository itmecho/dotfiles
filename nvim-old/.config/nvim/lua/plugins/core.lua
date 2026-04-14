return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        float = {
          solid = true,
          transparent = true,
        },
        flavour = 'macchiato',
        auto_integrations = true,
      })
      vim.cmd.colorscheme('catppuccin-nvim')
    end,
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
  -- { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  -- { 'lewis6991/gitsigns.nvim' },
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },
  { 'echasnovski/mini.ai', version = '*' },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      -- OR 'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = true,
    keys = {
      { '<leader>pv', '<cmd>Octo pr view<cr>' },
      { '<leader>pb', '<cmd>Octo pr browser<cr>' },
    },
    cmd = {'Octo'},
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
  },
}
