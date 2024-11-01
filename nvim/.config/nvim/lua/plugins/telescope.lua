return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'folke/trouble.nvim',
  },
  lazy = false,
  keys = {
    -- Find
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'List buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'List helptags' },
    {
      '<leader>fp',
      string.format('<cmd>Telescope find_files find_command=fd,--type,f,.proto$ cwd=%s<cr>', os.getenv('CLOUDPATH')),
      desc = 'List proto files',
    },
    {
      '<leader>fk',
      string.format('<cmd>Telescope find_files find_command=fd,--type,f cwd=%s<cr>', os.getenv('CLOUDPATH')..'/kustomize'),
      desc = 'Find kustomize files',
    },

    -- Search
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>sw', 'yiw:Telescope grep_string search=<c-r>"<cr>', desc = 'Search for current word in files' },
    {
      '<leader>sw',
      'y:Telescope grep_string search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in files',
    },
    {
      '<leader>sh',
      'y:Telescope help_tags search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in help',
    },
  },
  config = function()
    local open_with_trouble = require('trouble.sources.telescope').open
    local ts = require('telescope')

    ts.setup({
      defaults = {
        mappings = {
          i = { ['<c-t>'] = open_with_trouble },
          n = { ['<c-t>'] = open_with_trouble },
        },
      },
    })
  end,
}
