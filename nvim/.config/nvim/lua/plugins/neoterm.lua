return {
  'itmecho/neoterm.nvim',
  config = function()
    vim.keymap.set('n', '<leader>to', '<cmd>NeotermOpen<CR>')
    vim.keymap.set('n', '<leader>to', '<cmd>NeotermOpen<CR>')
    vim.keymap.set('n', '<leader>tc', '<cmd>NeotermClose<CR>')
    vim.keymap.set('n', '<leader>tt', '<cmd>NeotermToggle<CR>')
    vim.keymap.set('n', '<leader>tf', "<cmd>lua require'neoterm'.open({mode='fullscreen'})<CR>")
    vim.keymap.set('n', '<leader>ts', ':NeotermRun ', { silent = false })
    vim.keymap.set('n', '<leader>tr', '<cmd>NeotermRerun<CR>')
    vim.keymap.set('n', '<leader>tx', '<cmd>NeotermExit<CR>')
    vim.keymap.set('t', '<leader>tc', '<cmd>NeotermClose<CR>')
    vim.keymap.set('t', '<leader>tt', '<cmd>NeotermToggle<CR>')
    vim.keymap.set('t', '<leader>tn', '<C-\\><C-n>')
    vim.keymap.set('t', '<leader>tx', '<cmd>NeotermExit<CR>')
  end
}
