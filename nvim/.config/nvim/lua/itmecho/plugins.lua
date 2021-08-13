require("packer").startup(
    function(use)
        -- Packer
        use {"wbthomason/packer.nvim"}

        -- LSP
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "nvim-lua/lsp_extensions.nvim"
        use "folke/lsp-trouble.nvim"

        -- DAP
        use "mfussenegger/nvim-dap"

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"nvim-treesitter/nvim-treesitter-textobjects"}

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use "nvim-telescope/telescope-fzy-native.nvim"

        -- Statusline
        use "hoob3rt/lualine.nvim"

        -- Git
        use {
            "TimUntersberger/neogit",
            requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"}
        }
        use "pwntester/octo.nvim"

        -- Misc UI
        use "folke/which-key.nvim"
        use "kyazdani42/nvim-web-devicons"

        -- QoL
        use "tpope/vim-commentary"
        -- use "tpope/vim-fugitive"

        -- Neoterm
        -- use "itmecho/neoterm.nvim"
        use "~/src/neoterm.nvim"

        -- Dart
        use "dart-lang/dart-vim-plugin"

        -- Fish
        use "blankname/vim-fish"

        -- Prettier
        use "prettier/vim-prettier"

        -- Rust
        use "simrat39/rust-tools.nvim"

        -- TOML
        use "cespare/vim-toml"

        -- Color Schemes
        use {"dracula/vim", as = "dracula"}
        use "arcticicestudio/nord-vim"
        use "folke/tokyonight.nvim"
    end
)
