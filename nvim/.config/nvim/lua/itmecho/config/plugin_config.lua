require("nvim-treesitter.configs").setup(
    {
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
            "yaml"
        },
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["iP"] = "@parameter.inner"
                }
            },
            swap = {
                enable = true,
                swap_next = {
                    ["gsn"] = "@parameter.inner"
                },
                swap_previous = {
                    ["gsp"] = "@parameter.inner"
                }
            }
        }
    }
)

require("telescope").setup(
    {
        color_devicons = true,
        shorten_path = true,
        mappings = {
            i = {
                ["<C-q>"] = "send_to_qflist"
            }
        },
        pickers = {
            buffers = {
                sort_lastused = true,
                mappings = {
                    i = {
                        ["<c-d>"] = "delete_buffer"
                    }
                }
            }
        }
    }
)

require("telescope").load_extension("fzy_native")

require("nvim-web-devicons").setup()

require("neogit").setup(
    {
        disable_commit_confirmation = true,
        integrations = {diffview = true}
    }
)

require("gitsigns").setup()

require("colorizer").setup()

require("indent_blankline").setup(
    {
        char = "|",
        buftype_exclude = {"terminal"}
    }
)

require("lspkind").init()

require("rust-tools").setup({})

require("compe").setup(
    {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 300,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
            border = "single"
        },
        source = {
            path = true,
            buffer = true,
            calc = false,
            vsnip = false,
            nvim_lsp = true,
            nvim_lua = true,
            spell = false,
            tags = false,
            snippets_nvim = false,
            treesitter = true
        }
    }
)

vim.g["prettier#quickfix_enabled"] = false

-- vim.g.neoformat_enabled_typescript = {"prettier"}
