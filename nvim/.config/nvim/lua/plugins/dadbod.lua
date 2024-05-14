local u = require('itmecho.utils.dadbod')

return {
  { 'tpope/vim-dadbod' },
  {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    cmd = { 'DBUI' },
    config = function()
      vim.g.dbs = {
        test2_schooldb = u.connect('test2', 'test2_schooldb'),
      }
    end,
  },
  { 'kristijanhusak/vim-dadbod-completion' },
}
