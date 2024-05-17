return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'hrsh7th/nvim-cmp' },
    { 'kristijanhusak/vim-dadbod-completion' },
  },
  lazy = true,
  cmd = { 'DBUI' },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  config = function()
    require('plugins.config.dadbod')
  end,
}
