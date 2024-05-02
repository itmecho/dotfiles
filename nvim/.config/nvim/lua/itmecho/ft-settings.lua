local settings = {
  [{ 'proto', 'typescript', 'typescriptreact' }] = {
    colorcolumn = '100',
    textwidth = 100,
  },

  [{ 'go' }] = {
    colorcolumn = '120',
    textwidth = 120,
    expandtab = false,
  },

  [{ 'markdown' }] = {
    wrap = false,
  },
}

local group = vim.api.nvim_create_augroup('itmecho_ftsettings', { clear = true })

for pattern, values in pairs(settings) do
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = pattern,
    callback = function()
      for key, value in pairs(values) do
        vim.opt[key] = value
      end
    end,
  })
end
