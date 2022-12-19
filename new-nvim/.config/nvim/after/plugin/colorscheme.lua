if PluginLoaded('catppuccin') then
  require('catppuccin').setup({
    flavour = 'macchiato'
  })

  vim.cmd.colorscheme('catppuccin')
end
