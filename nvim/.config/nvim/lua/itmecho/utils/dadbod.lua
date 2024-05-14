local M = {}

local function get_secret(name)
  local project = 'sparx-web-test'
  if name:match('live') then
    project = 'sparx-production'
  end

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

function M.connect(env, db)
  if env ~= 'test2' and env ~= 'test1' and env ~= 'live' then
    error('unsupported env: ' .. env)
    return
  end

  local secret_name = 'test2-cloudsql-proxyuser-password'
  if env == 'test1' then
    secret_name = 'test1-cloudsql-proxyuser-password'
  end
  if env == 'live' then
    secret_name = 'live-cloudsql-proxyuser-password'
  end

  local password = get_secret(secret_name)

  return 'postgres://proxyuser:' .. password .. '@localhost:5444/' .. db .. '?sslmode=disable'
end

return M
