vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local snacks = require('snacks')
snacks.setup({
  gitbrowse = { enabled = true },
  indent = { enabled = true, animate = { enabled = false } },
  input = { enabled = true, win = { style = 'input', relative = 'cursor' } },
  picker = { enabled = true },
  statuscolumn = { enabled = false },
})

vim.keymap.set('n', '<leader>Gb', snacks.git.blame_line, { desc = 'Git blame line' })
vim.keymap.set({ 'n', 'v' }, '<leader>Go', function()
  snacks.gitbrowse()
end, { desc = 'Git browse' })
