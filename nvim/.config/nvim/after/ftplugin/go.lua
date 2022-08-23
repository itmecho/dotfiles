vim.bo.textwidth = 120
vim.wo.colorcolumn = '120'
vim.bo.expandtab = false
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

vim.cmd("command! -bang GoLines call v:lua.RunFormatCommand('golines -m 120 --base-formatter=gofmt')")

vim.keymap.set('n', '<leader><leader>t', require('itmecho.telescope').gotest)

local ts = require('itmecho.ts')

local function run_test(mode)
  local filter = ''
  if mode ~= 'all' then
    local name = nil
    if mode == 'exact' then
      name = ts.get_test_name()
    else
      name = ts.get_function_name()
    end
    if name ~= nil then
      filter = " -run='" .. name .. "'"
    end
  end

  local path = vim.fn.expand('%:h')

  -- Run in harpoon terminal 1
  local ht = require('harpoon.term')
  ht.gotoTerminal(1)
  ht.sendCommand(1, 'go test -count=1 ./' .. path .. '/...' .. filter)
  vim.cmd('norm G')
end

local test_cmd = function(name, mode)
  vim.api.nvim_create_user_command(name, function()
    run_test(mode)
  end, {})
end

test_cmd('RunTest', 'exact')
test_cmd('RunTestFunc', 'function')
test_cmd('RunTests', 'all')
