return {
  'jose-elias-alvarez/null-ls.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    local nl = require('null-ls')
    local Path = require('plenary.path')

    nl.setup({
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          --[[ vim.cmd("augroup LspFormatting")
        vim.cmd("autocmd! * <buffer>")
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({timeout_ms = 15000})")
        vim.cmd("augroup END") ]]
          local group = vim.api.nvim_create_augroup('LspFormatting', { clear = false })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = group,
          })
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ timeout_ms = 15000 })
            end,
            group = group,
          })
        end
      end,
      -- debug = true,
      sources = {
        nl.builtins.code_actions.eslint_d.with({
          cwd = function()
            return vim.loop.cwd()
          end,
          timeout = 20000,
        }),
        nl.builtins.diagnostics.buf.with({
          condition = function()
            local check = Path:new(vim.loop.cwd()):joinpath('buf.yaml'):exists()
            if check then
              print('enabled buf fmt')
            end
            return check
          end,
        }),
        nl.builtins.diagnostics.eslint_d.with({
          cwd = function()
            return vim.loop.cwd()
          end,
          timeout = 20000,
        }),
        nl.builtins.formatting.black,
        nl.builtins.formatting.buf.with({
          condition = function()
            return Path:new(vim.loop.cwd()):joinpath('buf.yaml'):exists()
          end,
        }),
        nl.builtins.formatting.eslint_d.with({
          condition = function()
            return Path:new(vim.loop.cwd(), '.eslintrc.js')
          end,
          prefer_local = 'node_modules/.bin',
          cwd = function()
            return vim.loop.cwd()
          end,
        }),
        nl.builtins.formatting.golines.with({
          extra_args = { '-m', '120' },
        }),
        nl.builtins.formatting.prettier.with({
          filetypes = { 'css', 'astro' },
          -- condition = function()
          --   return not Path:new(vim.loop.cwd(), ".eslintrc.js")
          -- end,
          prefer_local = 'node_modules/.bin',
          cwd = function()
            return vim.loop.cwd()
          end,
        }),
        nl.builtins.formatting.rustfmt,
        nl.builtins.formatting.stylua,
        nl.builtins.formatting.terraform_fmt,
        nl.builtins.formatting.zigfmt,
      },
    })
  end,
}
