local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local config = {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 300,
		},
	}

	if server == "lua" then
		config["settings"] = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		}
	end

	if server == "rust" then
		config["settings"] = {
			["rust-analyzer"] = {
				cargo = {
					runBuildScripts = true,
				},
			},
		}
	end

	server:setup(config)
	vim.cmd([[do User LspAttachBuffers ]])
end)

require("lspkind").init({ preset = "codicons" })

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	update_in_insert = true,
-- })
