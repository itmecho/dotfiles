local settings = {
  [{ 'proto' }] = {
    commentstring = '// %s'
  },
  [{ 'sql' }] = {
    commentstring = '-- %s'
  },
  [{ 'proto', 'typescript', 'typescriptreact' }] = {
    colorcolumn = '100',
    textwidth = 100,
    expandtab = true,
    tabstop = 2,
    shiftwidth = 2,
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

local extra_filetypes = {'gotmpl'}

for _, ft in pairs(extra_filetypes) do
  vim.api.nvim_create_autocmd('BufRead', {
    group = group,
    pattern = '*.'..ft,
    callback = function()
      vim.opt.filetype = ft
    end,
  })
end

