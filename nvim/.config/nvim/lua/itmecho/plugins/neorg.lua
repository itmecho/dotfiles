return {
  'nvim-neorg/neorg',
  run = ':Neorg sync-parsers',
  requires = {
    'nvim-lua/plenary.nvim',
    'folke/zen-mode.nvim',
  },
  config = function()
    require('zen-mode').setup({
      window = {
        options = {
          number = false,
          relativenumber = false,
          listchars = '',
        },
      },
    })
    require('neorg').setup({
      load = {
        ['core.defaults'] = {},
        ['core.norg.concealer'] = {
          config = {
            conceal = true,
          },
        },
        ['core.presenter'] = {
          config = {
            zen_mode = 'zen-mode',
          },
        },
        ['core.norg.dirman'] = {
          config = {
            workspaces = {
              presentations = '~/Documents/presentations',
              work = '~/Documents/work',
            },
          },
        },
      },
    })
  end,
}
