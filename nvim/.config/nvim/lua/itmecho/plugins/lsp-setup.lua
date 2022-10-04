return {
  'junnplus/lsp-setup.nvim',
  requires = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    require('lsp-setup').setup({
      default_mappings = false,
      mappings = {
        gd = 'Telescope lsp_definitions',
        gD = 'lua vim.lsp.buf.declaration()',
        gT = 'Telescope lsp_type_definitions',
        gr = 'Telescope lsp_references',
        gI = 'Telescope lsp_implementations',
        gR = 'lua vim.lsp.buf.rename()',
        ga = 'lua vim.lsp.buf.code_action()',
        gs = 'Telescope lsp_document_symbols',
        gS = 'Telescope lsp_dynamic_workspace_symbols',
        gx = 'LspRestart',
        go = 'SymbolsOutline',
        K = 'lua vim.lsp.buf.hover()',
      },
      on_attach = function(client)
        if client.name ~= 'null-ls' then
          client.server_capabilities.documentFormattingProvider = false
        end
      end,
      servers = {
        astro = {},
        emmet_ls = {},
        gopls = {
          flags = {
            debounce_text_changes = 300,
          },
        },
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
            },
          },
        },
        sumneko_lua = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = { 'vim', 's', 't', 'i', 'c', 'fmt', 'fmta' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
              },
            },
          },
        },
        tailwindcss = {},
        tsserver = {
          flags = {
            debounce_text_changes = 300,
          },
        },
      },
    })
  end,
}
