require("lspinstall").setup() -- important

local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local config = {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 300
        }
    }

    if server == "lua" then
        config["settings"] = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ";")
                },
                diagnostics = {
                    globals = {"vim"}
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                }
            }
        }
    end

    if server == "rust" then
        config["settings"] = {
            ["rust-analyzer"] = {
                cargo = {
                    runBuildScripts = true
                }
            }
        }
    end

    require("lspconfig")[server].setup(config)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = true
    }
)
