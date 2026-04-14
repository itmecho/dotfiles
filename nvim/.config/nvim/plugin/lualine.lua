vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})
require('lualine').setup({
  sections = {
    lualine_a = {},
    lualine_b = { 'filetype' },
    lualine_c = { 'diagnostics' },
    lualine_x = { 'diff' },
    lualine_y = { 'branch' },
    lualine_z = { "os.date('%H:%M')" },
  },
})
