local nvim_lsp = require('nvim_lsp')
local on_attach = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

nvim_lsp.gopls.setup{on_attach = on_attach}

nvim_lsp.jsonls.setup{on_attach = on_attach}

nvim_lsp.omnisharp.setup{on_attach = on_attach}

nvim_lsp.pyls.setup{on_attach = on_attach}

nvim_lsp.rust_analyzer.setup{on_attach = on_attach}

nvim_lsp.terraformls.setup{
    on_attach = on_attach;
    filetypes = { "terraform", "hcl" };
}
