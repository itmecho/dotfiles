return function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"astro",
			"dockerfile",
			"fish",
			"go",
			"hcl",
			"html",
			"javascript",
			"lua",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"yaml",
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		playground = {
			enabled = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["iP"] = "@parameter.inner",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["gsn"] = "@parameter.inner",
				},
				swap_previous = {
					["gsp"] = "@parameter.inner",
				},
			},
		},
	})
end
