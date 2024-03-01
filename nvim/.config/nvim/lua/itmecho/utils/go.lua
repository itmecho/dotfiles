local Path = require('plenary.path')

local M = {}

function M.playground()
  local tmp_dir = vim.fn.trim(vim.fn.system('mktemp -d'))
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

return M
