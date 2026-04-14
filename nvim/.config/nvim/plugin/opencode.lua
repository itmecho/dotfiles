vim.pack.add({ 'https://github.com/NickvanDyke/opencode.nvim' })
-- dependencies = {
--   { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
-- },

vim.o.autoread = true

vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
  require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode' })
vim.keymap.set({ 'n', 't' }, '<leader>at', function()
  require('opencode').toggle()
end, { desc = 'Toggle opencode' })
