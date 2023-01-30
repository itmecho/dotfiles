if PluginLoaded('indent-blankline.nvim') then
  require('indent_blankline').setup({
    char = '|',
    buftype_exclude = { 'terminal' },
  })
end
