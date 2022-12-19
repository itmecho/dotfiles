if PluginLoaded('telescope.nvim') then
  local ts = require('telescope')
  ts.setup({
    defaults = require('telescope.themes').get_ivy(),
    color_devicons = true,
    shorten_path = true,
    extensions = {
      file_browser = {
        theme = 'ivy'
      },
    },
  })
  ts.load_extension('file_browser')

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files)
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>')
  vim.keymap.set('n', '<leader>fi', builtin.live_grep)
  vim.keymap.set('n', '<leader>fc', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
  vim.keymap.set('n', '<leader>bl', builtin.buffers)
end
