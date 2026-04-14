local rootContains = function(files)
  local lspconfig = require('lspconfig')
  for _, file in ipairs(files) do
    local root_dir = lspconfig.util.root_pattern(file)(vim.api.nvim_buf_get_name(0))
    if root_dir ~= nil then
      return true
    end
  end
  return false
end

local autoPrettier = function()
  if rootContains({ '.oxfmtrc.json' }) then
    local formatters = { 'oxfmt' }
    if rootContains({ '.oxlintrc.json' }) then
      table.insert(formatters, 1, 'oxlint')
    end
    return formatters
  end

  if rootContains({ 'deno.json' }) then
    return { 'deno_fmt' }
  end

  if rootContains({ 'biome.json' }) then
    return { 'biome-check' }
  end

  local formatters = { 'prettier' }
  if rootContains({ 'eslint.config.mjs', '.eslintrc', '.eslintrc.cjs', '.eslintrc.js', '.eslintrc.json' }) then
    table.insert(formatters, 'eslint_d')
  end
  return formatters
end

local function bufContentContains(bufnr, search)
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n')
  return string.match(content, search)
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      astro = autoPrettier,
      c = { 'clang-format' },
      css = { 'prettier' },
      go = { 'goimports-reviser', 'golines' },
      html = { 'prettier' },
      javascript = autoPrettier,
      javascriptreact = autoPrettier,
      json = { 'jq' },
      lua = { 'stylua' },
      odin = { lsp_format = 'fallback' },
      php = { 'pint' },
      python = { 'ruff_format' },
      rust = { 'rustfmt' },
      sql = { 'sql_formatter' },
      svelte = autoPrettier,
      templ = { 'templ' },
      terraform = { 'terraform_fmt' },
      typescript = autoPrettier,
      typescriptreact = autoPrettier,
      vue = autoPrettier,
      zig = { 'zigfmt' },
    },
    formatters = {
      golines = {
        args = { '--max-len', '120', '--base-formatter', 'gofmt' },
      },
      ['goimports-reviser'] = {
        prepend_args = { '-rm-unused' },
      },
      oxlint = {
        prepend_args = { '--fix-suggestions', '--fix-dangerously' },
      },
      sql_formatter = function(bufnr)
        if bufContentContains(bufnr, '$1') then
          return { args = { '-l', 'postgresql' } }
        end
        return nil
      end,
    },
    notify_on_error = false,
    notify_no_formatters = true,
  },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ bufnr = 0, timeout_ms = 10000 })
      end,
      desc = 'Conform format',
    },
  },
}
