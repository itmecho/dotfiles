local M = {}

function M.get_secret(project, name)
  local cmd = string.format('gcloud secrets versions access latest --secret %s --project %s', name, project)

  print(string.format('fetching secret %s from %s', name, project))
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

local proxies = {}

function M.start_cloudsqlproxy(instance, port)
  local key = string.format('%s:%s', instance, port)
  if proxies[key] == true then
    print('proxy already running for ' .. key)
    return
  end
  print('starting proxy for ' .. key)

  local cmd = string.format('cloud_sql_proxy -instances=%s=tcp:%d', instance, port)

  proxies[key] = true
  vim.fn.jobstart(cmd, {
    on_exit = function(_, status)
      proxies[key] = false
      if status ~= 0 then
        error('got non-zero status when running cloud sql proxy for ' .. instance)
      end
    end,
  })
end

return M
