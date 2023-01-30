return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup({
      flavour = 'macchiato'
    })

    vim.cmd.colorscheme('catppuccin')
  end
}
