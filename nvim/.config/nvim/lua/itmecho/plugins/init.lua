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
    config = require("itmecho.plugins.config.nvim_cmp"),
  })
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        width = 60,
      }
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = require("itmecho.plugins.config.null_ls"),
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

  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
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
    before = "neorg",
    run = ":TSUpdate",
    requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = require("itmecho.plugins.config.nvim_treesitter"),
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
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
      ts.load_extension("ui-select")
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
