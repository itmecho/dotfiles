local M = {}

local password_cache = {}

local function get_secret(name)
  if password_cache[name] ~= nil then
    print('using cached password for '..name)
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

---@class ConnectOpts
---@field env string

---@param db string
---@param opts ConnectOpts|nil
function M.connect(db, opts)
  opts = vim.tbl_extend('keep', opts or {}, {
    env = "test2",
    readonly = false,
  })

  if opts.env ~= 'test2' and opts.env ~= 'test1' and opts.env ~= 'live' then
    error('unsupported env: ' .. opts.env)
    return
  end

  local secret_name = 'test2-cloudsql-proxyuser-password'
  if opts.env == 'test1' then
    secret_name = 'test1-cloudsql-proxyuser-password'
  end
  if opts.env == 'live' then
    secret_name = 'live-cloudsql-proxyuser-password'
  end

  local password = get_secret(secret_name)

  local conn_string = 'postgres://proxyuser:' .. password .. '@localhost:5444/' .. db .. '?sslmode=disable'

  return conn_string
end

return M
