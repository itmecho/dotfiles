return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

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
  {
    'stevearc/aerial.nvim',
    opts = {
      autojump = true,
      highlight_on_jump = false,
      layout = {
        min_width = 30,
      },
      filter_kind = {
        'Class',
        'Constant',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>so', '<cmd>AerialToggle<cr>', desc = 'Toggle symbol outline' },
      { ']s', '<cmd>AerialNext<cr>', desc = 'Jump to next symbol' },
      { '[s', '<cmd>AerialPrev<cr>', desc = 'Jump to previous symbol' },
    },
  },
}
