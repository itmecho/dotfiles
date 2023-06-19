return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    -- Find
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = "List buffers" },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = "List buffers" },

    -- Search
    { '<leader>sg', '<cmd>Telescope live_grep<cr>',  desc = 'Live grep' },
    { '<leader>sw', 'yiw:Telescope grep_string search=<c-r>"<cr>', desc = 'Search for current word in files' },
    {
      '<leader>sw',
      'y:Telescope grep_string search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in files'
    },
    {
      '<leader>sh',
      'y:Telescope help_tags search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in help'
    },
  },
}
