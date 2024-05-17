local function get_secret(project, name)
  local cmd = 'gcloud secrets versions access latest --secret ' .. name .. ' --project ' .. project

  local output = ''
  local job = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      if data[1] ~= '' then
        output = data[1]
      end
    end,
  })
  local status = vim.fn.jobwait({ job })
  if status[1] ~= 0 then
    error('failed to get secret')
  end

  return output
end

local function make_db(name, db, s)
  return {
    name = name,
    url = string.format('postgres://%s:%s@127.0.0.1:%d/%s?sslmode=disable', s.user, s.password, s.port, db),
  }
end

local function start_cloudsqlproxy(instance, port)
  local cmd = string.format('cloud_sql_proxy -instances=%s=tcp:%d', instance, port)

  vim.fn.jobstart(cmd, {
    on_exit = function(_, status)
      if status ~= 0 then
        error('got non-zero status when running cloud sql proxy for ' .. instance)
      end
    end,
  })
end

local settings = {
  maths = {
    test = {
      user = 'proxyuser',
      port = 5600,
      password = get_secret('sparx-web-test', 'test2-cloudsql-proxyuser-password'),
    },
    live_readonly = {
      user = 'rouser',
      port = 5601,
      password = get_secret('sparx-production', 'cloudsql-readonly-user-password'),
    },
  },
  reader = {
    test = {
      user = 'englishuser',
      port = 5700,
      password = get_secret('sparx-web-test', 'test2-reading-database-password'),
    },
  },
}

-- maths
start_cloudsqlproxy('sparx-web-test:europe-west1:test-general-2019-12', settings.maths.test.port)
start_cloudsqlproxy('sparx-production:europe-west1:databases', settings.maths.live_readonly.port)
-- reader
start_cloudsqlproxy('sparx-web-test:europe-west1:readingdb', settings.reader.test.port)

vim.g.dbs = {
  -- maths
  make_db('test2-schooldb', 'test2_schooldb', settings.maths.test),
  make_db('test2_wondesyncdb', 'test2_wondesyncdb', settings.maths.test),
  make_db('live_schooldb (ro)', 'schooldb', settings.maths.live_readonly),
  make_db('live_wondesyncdb (ro)', 'wondesyncdb', settings.maths.live_readonly),
  -- reader
  make_db('test2_readingdb', 'englishdb-test2', settings.reader.test),
}

require('cmp').setup.filetype({ 'sql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  },
})
