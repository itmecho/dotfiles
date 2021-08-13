local nvim_lsp = require("lspconfig")

local function on_attach()
    vim.bo.omnifunc = "v:lua.lsp.omnifunc"
end

nvim_lsp.dartls.setup {
    on_attach = on_attach
}

nvim_lsp.gopls.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 300
    }
}

nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach
}

nvim_lsp.sumneko_lua.setup {
    cmd = {
        "/usr/bin/lua-language-server",
        "-E",
        "/usr/share/lua-language-server/main.lua"
    },
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim", "use"}
            }
        }
    }
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 300
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = true
    }
)
