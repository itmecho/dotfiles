vim.pack.add({
  'https://github.com/pwntester/octo.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
})

require('octo').setup()
vim.keymap.set('n', '<leader>pv', '<cmd>Octo pr view<cr>')
vim.keymap.set('n', '<leader>pb', '<cmd>Octo pr browser<cr>')
