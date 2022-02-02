local lsp_installer = require("nvim-lsp-installer")

local function on_attach()
	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	if ft ~= "lua" then
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	end

	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, { buffer = 0 })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
	vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = 0 })
	vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", { buffer = 0 })
	vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = 0 })
	vim.keymap.set("n", "ga", "<cmd>Telescope lsp_code_actions theme=cursor<cr>", { buffer = 0 })
end

lsp_installer.on_server_ready(function(server)
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local config = {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 300,
		},
		on_attach = on_attach,
	}

	if server.name == "sumneko_lua" then
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
