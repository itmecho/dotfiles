vim.api.nvim_create_user_command(
  'GoPlayground',
  require('itmecho.utils.go').playground,
  { desc = 'Create a go playground in a temporary directory' }
)
