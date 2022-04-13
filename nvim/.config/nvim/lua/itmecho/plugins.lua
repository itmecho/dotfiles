return require("packer").startup(function(use)
  -- Packer
  use({ "wbthomason/packer.nvim" })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/itmecho/snippets" })
    end,
  })
  use({ "saadparwaiz1/cmp_luasnip", requires = { "L3MON4D3/LuaSnip" } })
  use({
    "hrsh7th/nvim-cmp",
    requires = { "onsails/lspkind-nvim" },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format(),
        },
        mapping = {
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      })
    end,
  })
  -- use({
  -- 	"simrat39/symbols-outline.nvim",
  -- 	config = function()
  -- 		vim.g.symbols_outline = {
  -- 			width = 60,
  -- 		}
  -- 	end,
  -- })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local nl = require("null-ls")
      local Path = require("plenary.path")

      nl.setup({
        on_attach = function(client)
          if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
          end
        end,
        -- debug = true,
        sources = {
          nl.builtins.code_actions.eslint_d.with({
            cwd = function()
              return vim.loop.cwd()
            end,
            timeout = 20000,
          }),
          nl.builtins.diagnostics.eslint_d.with({
            cwd = function()
              return vim.loop.cwd()
            end,
            timeout = 20000,
          }),
          nl.builtins.diagnostics.protolint,
          nl.builtins.formatting.black,
          nl.builtins.formatting.eslint_d.with({
            condition = function()
              return Path:new(vim.loop.cwd(), ".eslintrc.js")
            end,
            prefer_local = "node_modules/.bin",
            cwd = function()
              return vim.loop.cwd()
            end,
          }),
          nl.builtins.formatting.golines,
          nl.builtins.formatting.prettier.with({
            condition = function()
              return not Path:new(vim.loop.cwd(), ".eslintrc.js")
            end,
            prefer_local = "node_modules/.bin",
            cwd = function()
              return vim.loop.cwd()
            end,
          }),
          nl.builtins.formatting.rustfmt,
          nl.builtins.formatting.stylua,
          nl.builtins.formatting.terraform_fmt,
        },
      })
    end,
  })
  use("nvim-lua/lsp_extensions.nvim")
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  })
  use("ray-x/lsp_signature.nvim")
  use("williamboman/nvim-lsp-installer")

  -- Navigation
  use({ "ThePrimeagen/harpoon", requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } } })

  -- Notifications
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({ timeout = 2000 })
    end,
  })

  -- Formatting
  -- use("sbdchd/neoformat")
  -- use("mhartington/formatter.nvim")
  use("~/src/formatter.nvim")

  -- DAP
  use("mfussenegger/nvim-dap")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
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
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function()
      local ts = require("telescope")
      ts.setup({
        defaults = require("telescope.themes").get_ivy(),
        color_devicons = true,
        shorten_path = true,
        mappings = {
          i = {
            ["<C-q>"] = "send_to_qflist",
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
          },
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
      })
      ts.load_extension("fzy_native")
      ts.load_extension("file_browser")
    end,
  })

  -- Statusline
  use("nvim-lualine/lualine.nvim")
  use("nvim-lua/lsp-status.nvim")

  -- Git
  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        integrations = { diffview = true },
      })
    end,
  })
  use("pwntester/octo.nvim")
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  -- Neorg
  use({
    "nvim-neorg/neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                journal = "~/Documents/journal",
                notes = "~/Documents/notes",
                presentations = "~/Documents/presentations",
              },
            },
          },
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.norg.concealer"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
        },
      })
    end,
    requires = { "nvim-lua/plenary.nvim", "folke/zen-mode.nvim" },
  })

  -- Misc UI
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "|",
        buftype_exclude = { "terminal" },
      })
    end,
  })
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })

  -- QoL
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  -- use("tpope/vim-commentary")
  -- use "tpope/vim-fugitive"

  -- Neoterm
  -- use "itmecho/neoterm.nvim"
  use("~/src/neoterm.nvim")
  use("~/src/cht.nvim")

  -- Dart
  use("dart-lang/dart-vim-plugin")

  -- Fish
  use("blankname/vim-fish")

  -- Kitty
  use("fladson/vim-kitty")

  -- MDX
  use("jxnblk/vim-mdx-js")

  -- Prettier
  use("prettier/vim-prettier")

  -- Rust
  use({
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({})
    end,
  })

  -- Color Schemes
  use({ "dracula/vim", as = "dracula" })
  use("shaunsingh/nord.nvim")
  use("folke/tokyonight.nvim")
end)
