vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
})

require('catppuccin').setup({
  float = {
    solid = true,
    transparent = true,
  },
  flavour = 'macchiato',
  auto_integrations = true,
})

vim.cmd.colorscheme('catppuccin-nvim')
