return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    branch = '0.1.x',
    config = function()
      local ts = require('telescope')
      ts.setup({
        defaults = require('telescope.themes').get_ivy(),
        color_devicons = true,
        shorten_path = true,
        extensions = {
          file_browser = {
            theme = 'ivy',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })
      ts.load_extension('file_browser')
      ts.load_extension('ui-select')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>')
      vim.keymap.set('n', '<leader>fi', builtin.live_grep)
      vim.keymap.set('n', '<leader>fc', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
      vim.keymap.set('n', '<leader>bl', builtin.buffers)
    end,
  },
  'nvim-telescope/telescope-file-browser.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
}
