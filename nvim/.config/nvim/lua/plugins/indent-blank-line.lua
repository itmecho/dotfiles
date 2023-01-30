return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('indent_blankline').setup({
      char = '|',
      buftype_exclude = { 'terminal' },
    })
  end
}
