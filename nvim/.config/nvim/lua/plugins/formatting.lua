local tsjs = function()
  return {
    require('formatter.filetypes.' .. vim.bo.filetype).prettier,
    require('formatter.filetypes.' .. vim.bo.filetype).eslint_d,
  }
end

return {
  'mhartington/formatter.nvim',
  config = function()
    require('formatter').setup({
      logging = true,
      log_level = vim.log.levels.INFO,
      filetype = {
        lua = { require('formatter.filetypes.lua').stylua },
        go = {
          function()
            return {
              exe = 'golines',
              args = {
                '--max-len',
                '120',
                '--base-formatter',
                'goimports',
              },
              stdin = true,
            }
          end,
        },
        css = { require('formatter.defaults.prettier') },
        javascript = tsjs(),
        javascriptreact = tsjs(),
        typescript = tsjs(),
        typescriptreact = tsjs(),
      },
    })
  end,
  keys = {
    { '<leader>cf', '<cmd>Format<cr>', desc = 'Format current buffer' },
  },
}
