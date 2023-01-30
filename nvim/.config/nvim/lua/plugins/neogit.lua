return {
  'TimUntersberger/neogit',
  config = function()
    vim.keymap.set('n', '<leader>gs', function()
      require('neogit').open()
    end)
  end,
}
