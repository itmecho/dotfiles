local gcp = require('itmecho.utils.gcp')

local settings = {
  maths = {
    test = {
      instance = 'sparx-web-test:europe-west1:test-general-2019-12',
      user = 'proxyuser',
      port = 5600,
      password = { project = 'sparx-web-test', name = 'test2-cloudsql-proxyuser-password' },
    },
    live_readonly = {
      instance = 'sparx-production:europe-west1:databases',
      user = 'rouser',
      port = 5601,
      password = { project = 'sparx-production', name = 'cloudsql-readonly-user-password' },
    },
  },
  reader = {
    test = {
      instance = 'sparx-web-test:europe-west1:readingdb',
      user = 'englishuser',
      port = 5700,
      password = { project = 'sparx-web-test', name = 'test2-reading-database-password' },
    },
  },
}

local function make_db(name, db, s)
  return {
    name = name,
    url = function()
      local password = gcp.get_secret(s.password.project, s.password.name)
      gcp.start_cloudsqlproxy(s.instance, s.port)

      return string.format('postgres://%s:%s@127.0.0.1:%d/%s?sslmode=disable', s.user, password, s.port, db)
    end,
  }
end

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
    vim.g.dbs = {
      make_db('test2-schooldb', 'test2_schooldb', settings.maths.test),
      make_db('test2-wondesyncdb', 'test2_wondesyncdb', settings.maths.test),
      make_db('live-schooldb (ro)', 'schooldb', settings.maths.live_readonly),
      make_db('live-wondesyncdb (ro)', 'wondesyncdb', settings.maths.live_readonly),
      make_db('test2_readingdb', 'englishdb-test2', settings.reader.test),
    }
  end,
}
