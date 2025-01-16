return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = true,
      },
      { 'saghen/blink.cmp' },
    },
    config = function()
      local on_attach = function(_, bufnr)
        vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set('n', '<leader>cs', '<cmd>Telescope lsp_document_symbols<cr>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>ct', '<cmd>Telescope lsp_type_definitions<cr>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>h', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end, { buffer = bufnr })
      end

      local lspconfig = require('lspconfig')
      local servers = {
        cssls = {},
        cssmodules_ls = {
          on_attach = function(client)
            -- avoid accepting `definitionProvider` responses from this LSP
            client.server_capabilities.definitionProvider = false
          end,
          init_options = {
            camelCase = 'false',
          },
        },
        emmet_ls = {},
        eslint = {},
        golangci_lint_ls = {},
        gopls = {
          settings = {
            gopls = {
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
                arrayIndex = 'Auto',
                await = true,
                paramName = true,
                paramType = true,
                semicolon = true,
                setType = true,
              },
            },
          },
        },
        stylelint_lsp = {
          filetypes = { 'css' },
        },
        tailwindcss = {},
        templ = {},
        ts_ls = {
          root_dir = lspconfig.util.root_pattern('package.json'),
          single_file_support = false,
          init_options = {
            preferences = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    end,
  },
  { 'j-hui/fidget.nvim', config = true },
}
