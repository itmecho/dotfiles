require("itmecho.utils").set_autocommands(
    "itmecho_rust",
    {
        {"BufWritePre", "*", "lua vim.lsp.buf.formatting_sync()"}
    }
)
