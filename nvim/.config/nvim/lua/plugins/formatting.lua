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
  if rootContains({ 'deno.json' }) then
    return { 'deno_fmt' }
  end

  local formatters = { 'prettier' }
  if rootContains({ '.eslintrc', '.eslintrc.cjs', '.eslintrc.js', '.eslintrc.json' }) then
    table.insert(formatters, 'eslint_d')
  end
  return formatters
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'golines', 'goimports-reviser' },
      css = { 'prettier' },
      html = { 'prettier' },
      javascript = autoPrettier,
      javascriptreact = autoPrettier,
      json = { 'jq' },
      sql = { 'sql_formatter' },
      templ = { 'templ' },
      terraform = { 'terraform_fmt' },
      typescript = autoPrettier,
      typescriptreact = autoPrettier,
    },
    formatters = {
      golines = {
        args = { '--max-len', '120', '--base-formatter', 'gofmt' },
      },
      ['goimports-reviser'] = {
        prepend_args = { '-rm-unused' },
      },
    },
    notify_on_error = true,
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

-- return {
--   'mhartington/formatter.nvim',
--   config = function()
--     require('formatter').setup({
--       logging = true,
--       log_level = vim.log.levels.INFO,
--       filetype = {
--         astro = { prettierWithParser('astro') },
--         lua = { require('formatter.filetypes.lua').stylua },
--         go = {
--           {
--             exe = 'golines',
--             args = {
--               '--max-len',
--               '120',
--             },
--             stdin = true,
--           },
--           {
--             exe = 'goimports-reviser',
--             args = { '-rm-unused' },
--           },
--         },
--         blade = {
--           {
--             exe = 'blade-formatter',
--             args = { '--stdin' },
--             stdin = true,
--           },
--         },
--         css = { require('formatter.defaults.prettier') },
--         html = { require('formatter.defaults.prettier') },
--         javascript = jsOrTs('javascript'),
--         javascriptreact = jsOrTs('javascriptreact'),
--         markdown = { prettierWithParser('markdown') },
--         svelte = { prettierWithParser('svelte') },
--         typescript = jsOrTs('typescript'),
--         typescriptreact = jsOrTs('typescriptreact'),
--         ocaml = {
--           {
--             exe = 'ocamlformat',
--             args = {
--               '--name',
--               vim.api.nvim_buf_get_name(0),
--               '-',
--             },
--             stdin = true,
--           },
--         },
--         php = { require('formatter.filetypes.php').pint },
--         rust = { require('formatter.filetypes.rust').rustfmt },
--         sql = {
--           {
--             exe = 'sql-formatter',
--             args = { '-l', 'postgresql' },
--             stdin = true,
--           },
--         },
--         templ = {
--           {
--             exe = 'templ',
--             args = { 'fmt' },
--             stdin = true,
--           },
--         },
--         terraform = {
--           {
--             exe = 'terraform',
--             args = { 'fmt', '-' },
--             stdin = true,
--           },
--         },
--         zig = {
--           {
--             exe = 'zig',
--             args = { 'fmt', '--stdin' },
--             stdin = true,
--           },
--         },
--       },
--     })
--   end,
--   keys = {
--     {
--       '<leader>cf',
--       function()
--         if vim.opt.filetype:get() == 'go' then
--           local params = vim.lsp.util.make_range_params()
--           params.context = { only = { 'source.organizeImports' } }
--           local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
--           for cid, res in pairs(result or {}) do
--             for _, r in pairs(res.result or {}) do
--               if r.edit then
--                 local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
--                 vim.lsp.util.apply_workspace_edit(r.edit, enc)
--               end
--             end
--           end
--         end
--         vim.cmd.Format()
--       end,
--       desc = 'Format current buffer',
--     },
--   },
-- }
