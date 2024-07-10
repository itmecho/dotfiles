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

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = {
            'src/parser.c',
            -- 'src/scanner.cc',
          },
          branch = 'main',
          generate_requires_npm = true,
          requires_generate_from_grammar = true,
        },
        filetype = 'blade',
      }

      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      multiline_threshold = 1,
    },
  },
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
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_lua').load({ paths = { '../itmecho/snippets' } })
    end,
  },
  { 'nvim-neotest/nvim-nio' },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
    keys = {
      -- stylua: ignore start
      { '<leader>a', function() require'harpoon':list():add() end, desc = 'Add current buffer to harpoon' },
      { '<leader>h', function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end, desc = 'Toggle Harpoon quickmenu' },
      { '<leader>j', function() require'harpoon':list():select(1) end, desc = 'Go to harpoon entry 1' },
      { '<leader>k', function() require'harpoon':list():select(2) end, desc = 'Go to harpoon entry 2' },
      { '<leader>l', function() require'harpoon':list():select(3) end, desc = 'Go to harpoon entry 3' },
      { '<leader>;', function() require'harpoon':list():select(4) end, desc = 'Go to harpoon entry 4' },
      -- stylua: ignore end
    },
  },
  {
    'stevearc/oil.nvim',
    config = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },
}
