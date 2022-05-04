return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "dockerfile",
      "fish",
      "go",
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
