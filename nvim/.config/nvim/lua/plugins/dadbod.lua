local utils = require('itmecho.utils.dadbod')

local settings = {
  maths = {
    test = {
      user = 'proxyuser',
      port = 5600,
      secret = 'test2-cloudsql-proxyuser-password',
    },
    live = {
      user = 'proxyuser',
      port = 5601,
      secret = 'live-cloudsql-proxyuser-password',
    },
  },
  reader = {
    test = {
      user = 'englishuser',
      port = 5700,
      secret = 'test2-reading-database-password',
    },
  },
}

local function make_db(name, db, s)
  return {
    name = name,
    url = utils.connstring(db, s.user, s.secret, s.port),
  }
end

local function start_port_forwards()
  -- maths
  utils.start_cloudsqlproxy('sparx-web-test:europe-west1:test-general-2019-12', settings.maths.test.port)
  utils.start_cloudsqlproxy('sparx-production:europe-west1:databases', settings.maths.live.port)

  -- reader
  utils.start_cloudsqlproxy('sparx-web-test:europe-west1:readingdb', settings.reader.test.port)
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
    start_port_forwards()
    vim.g.dbs = {
      -- maths
      make_db('test2-schooldb', 'test2_schooldb', settings.maths.test),
      make_db('test2_wondesyncdb', 'test2_wondesyncdb', settings.maths.test),
      make_db('live_schooldb', 'schooldb', settings.maths.live),
      make_db('live_wondesyncdb', 'wondesyncdb', settings.maths.live),
      -- reader
      make_db('test2_readingdb', 'englishdb-test2', settings.reader.test),
    }

    require('cmp').setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}
