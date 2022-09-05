return {
  'nvim-lualine/lualine.nvim',
  requires = 'nvim-lua/lsp-status.nvim',
  config = function()
    local lsp_status = require('lsp-status')
    lsp_status.register_progress()
    lsp_status.config({
      indicator_errors = '%#DiagnosticSignError#%#DiagnoticSignOther#',
      indicator_warnings = '',
      indicator_info = '%#DiagnosticSignInfo#%#DiagnosticSignOther#',
      indicator_hint = '%#DiagnosticSignHint#ﬤ%#DiagnosticSignOther#',
      indicator_ok = '',
      status_symbol = '',
    })

    function LspDiagnostics()
      if #vim.lsp.get_active_clients() == 0 then
        return ''
      end

      local s = require('lsp-status').diagnostics(vim.api.nvim_get_current_buf())
      local items = {}
      if s.errors and s.errors > 0 then
        table.insert(items, '%#DiagnosticSignError#%#DiagnoticSignOther# ' .. s.errors)
      end
      if s.warnings and s.warnings > 0 then
        table.insert(items, '%#DiagnosticSignWarn#%#DiagnosticSignOther#' .. s.warnings)
      end
      if s.info and s.info > 0 then
        table.insert(items, '%#DiagnosticSignInfo#%#DiagnosticSignOther#' .. s.info)
      end
      if s.hints and s.hints > 0 then
        table.insert(items, '%#DiagnosticSignHint#ﬤ%#DiagnosticSignOther#' .. s.hints)
      end

      if #items == 0 then
        return ''
      end

      return table.concat(items, ' ')
    end

    require('lualine').setup({
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = vim.env.THEME:lower(),
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'filetype', colored = 1 },
        },
        lualine_c = { 'diagnostics' },
        lualine_x = {
          { 'filename', path = 1 },
        },
        lualine_y = {},
        lualine_z = { 'branch' },
      },
    })
  end,
}
