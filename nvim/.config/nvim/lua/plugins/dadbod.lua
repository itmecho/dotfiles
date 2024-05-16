return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'hrsh7th/nvim-cmp' },
    { 'kristijanhusak/vim-dadbod-completion' },
  },
  lazy = true,
  cmd = { 'DBUI' },
  init = function ()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  config = function()
    local connect = require('itmecho.utils.dadbod').connect
    vim.g.dbs = {
      { name = 'test2_schooldb', url = connect('test2_schooldb') },
      { name = 'test2_wondesyncdb', url = connect('test2_wondesyncdb') },
      { name = 'live_schooldb', url = connect('schooldb', { env = 'live' }) },
      { name = 'live_wondesyncdb', url = connect('wondesyncdb', { env = 'live' }) },
    }

    require('cmp').setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}
