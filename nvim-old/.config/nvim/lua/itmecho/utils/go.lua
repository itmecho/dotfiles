local Path = require('plenary.path')

local M = {}

M.playground = function()
  local tmp_dir = vim.fn.system('mktemp -d')
  tmp_dir = string.gsub(tmp_dir, '\n', '')
  tmp_dir = Path:new(tmp_dir)
  vim.fn.system('cd ' .. tmp_dir .. ' && go mod init playground')
  local main_file = tmp_dir:joinpath('main.go')
  main_file.write(
    main_file,
    [[package main

// use <leader>r to run the code
func main() {
	println("hi")
}
]],
    'w'
  )
  vim.cmd('tabnew')
  vim.cmd('tcd ' .. tmp_dir.filename)
  vim.cmd('e main.go')

  vim.keymap.set('n', '<leader>r', '<cmd>!go run .<cr>', { buffer = 0 })
end

M.go_to_tests = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  local test_file = file:gsub('.go$', '_test.go')
  vim.cmd('edit ' .. test_file)
end

return M
