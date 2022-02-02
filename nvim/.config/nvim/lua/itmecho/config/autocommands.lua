function RemoveTrailingWhiteSpace()
	local view = vim.fn.winsaveview()
	vim.cmd([[keeppatterns %s/\s\+$//e]])
	vim.fn.winrestview(view)
end

local u = require("itmecho.utils")

u.set_autocommands("itmecho_general", {
	{ "BufWritePost", "plugins.lua", "PackerCompile" },
	{ "ColorScheme", "*", "lua require('nvim-web-devicons').setup()" },
	{ "User", "LspProgressUpdate", "redrawstatus!" },
})

u.set_autocommands("formatting", {
	{ "BufWritePre", "*", "call v:lua.RemoveTrailingWhiteSpace()" },
	-- { "BufWritePre", "*", "Neoformat" },
	{ "BufWritePost", "*", "FormatWriteSync" },
})

u.set_autocommands("gotpl", {
	{ "BufNewFile,BufRead", "*.html.tpl", "set ft=gohtmltmpl" },
})
