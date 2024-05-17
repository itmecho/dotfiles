local M = {}

local password_cache = {}

local function get_secret(name)
  if password_cache[name] ~= nil then
    print('using cached password for ' .. name)
    return password_cache[name]
  end

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

  password_cache[name] = output
  return output
end

--- Starts cloudsqlproxy in the background
---
---@param instance any
---@param port any
function M.start_cloudsqlproxy(instance, port)
  local cmd = string.format('cloud_sql_proxy -instances=%s=tcp:%d', instance, port)

  vim.fn.jobstart(cmd, {
    on_exit = function(_, status)
      if status ~= 0 then
        error('got non-zero status when running cloud sql proxy for ' .. instance)
      end
    end,
  })
end

-- Returns a connection string where the value of the secret referenced by secret_name
-- is used as the password.
---@param db string
---@param username string
---@param secret_name string
---@param port integer
function M.connstring(db, username, secret_name, port)
  local password = get_secret(secret_name)

  return string.format('postgres://%s:%s@127.0.0.1:%d/%s?sslmode=disable', username, password, port, db)
end

return M
