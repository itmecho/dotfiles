return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      { 'saghen/blink.cmp' },
    },
    config = function()
      local servers = {
        biome = {},
        bzl = {},
        clangd = {},
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
        elixirls = {
          cmd = { '/Users/iainearl/.local/share/nvim/mason/bin/elixir-ls' },
          cmd_env = { SHELL = 'bash' },
        },
        eslint = {},
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
        golangci_lint_ls = {
          init_options = {
            command = {
              'golangci-lint',
              'run',
              '--output.json.path=stdout',
              '--output.tab.path=/dev/null',
              '--show-stats=false',
            },
          },
        },
        intelephense = {},
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
              workspace = {
                checkThirdParty = false,
                telemetry = { enable = false },
                library = {
                  '${3rd}/love2d/library',
                },
              },
            },
          },
        },
        ols = {},
        pylsp = {},
        ruff = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
              checkOnSave = true,
            },
          },
        },
        stylelint_lsp = {
          filetypes = { 'css' },
        },
        svelte = {},
        tailwindcss = {},
				templ = {},
        ts_ls = {
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
        zls = {},
      }

      local on_attach = function(_, bufnr)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
        vim.keymap.set('n', '<leader>ci', function()
          vim.lsp.buf.code_action({
            filter = function(a)
              return a.kind == 'source.organizeImports'
            end,
            apply = true,
          })
        end, { buffer = bufnr })
        vim.keymap.set('n', '<leader>h', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end, { buffer = bufnr })
      end

      for server, cfg in pairs(servers) do
        vim.lsp.config(
          server,
          vim.tbl_deep_extend('force', cfg, {
            on_attach = on_attach,
          })
        )
        vim.lsp.enable(server)
      end
    end,
  },
}
