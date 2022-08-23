local ht = require('harpoon.term')

local M = {}

M.delete_buffers = function(opts)
  opts = vim.tbl_extend('keep', opts or {}, {
    keep_current = false,
  })

  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  local count = 0
  for _, buf in pairs(bufs) do
    -- Skip current buffer if keep_current is set
    if not (buf == current_buf and opts.keep_current) then
      -- Only close listed buffers
      local listed = vim.api.nvim_buf_get_option(buf, 'buflisted')

      if listed then
        vim.api.nvim_buf_delete(buf, {})
        count = count + 1
      end
    end
  end

  print('closed ' .. count .. ' buffers')
end

local function install_lsp_servers(update)
  local installer = require('nvim-lsp-installer')
  local servers = require('nvim-lsp-installer.servers')

  local wanted = {
    'gopls',
    'rust_analyzer',
    'sumneko_lua',
    'tailwindcss',
    'tsserver',
  }

  installer.display()

  for _, server in pairs(wanted) do
    local ok, srv = servers.get_server(server)
    if ok then
      if srv:is_installed() ~= true or update then
        srv:install()
      end
    else
      print(server .. ' is not a valid lsp server')
    end
  end
end

function M.file_exists(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function M.install_lsp_servers()
  install_lsp_servers(false)
end

function M.update_lsp_servers()
  install_lsp_servers(true)
end

function M.stop_all_lsp_clients()
  local clients = vim.lsp.get_active_clients()
  vim.lsp.stop_client(clients)
  print('stopped ' .. #clients .. ' lsp clients')
end

function M.run_in_term(term_idx, cmd)
  ht.gotoTerminal(term_idx)
  ht.sendCommand(term_idx, cmd)
  vim.cmd('norm G')
end

return M
