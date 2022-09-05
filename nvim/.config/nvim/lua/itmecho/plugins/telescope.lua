return {
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-media-files.nvim' },
  },
  config = function()
    local ts = require('telescope')
    ts.setup({
      defaults = require('telescope.themes').get_ivy(),
      color_devicons = true,
      shorten_path = true,
      mappings = {
        i = {
          ['<C-q>'] = 'send_to_qflist',
        },
      },
      pickers = {
        find_files = {
          find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' },
        },
        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ['<c-d>'] = 'delete_buffer',
            },
          },
        },
      },
    })
    ts.load_extension('fzy_native')
    ts.load_extension('file_browser')
    ts.load_extension('media_files')
  end,
}
