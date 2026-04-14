vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/stevearc/oil.nvim',
})

require('oil').setup({
  default_file_explorer = false,
})

vim.keymap.set('n', '-', '<cmd>Oil<cr>')
