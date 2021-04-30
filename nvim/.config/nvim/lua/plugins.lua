vim.cmd("packadd packer.nvim")

return require("packer").startup(
    function()
        -- Packer
        use {"wbthomason/packer.nvim", opt = true}

        -- LSP
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "nvim-lua/lsp_extensions.nvim"
        use "glepnir/lspsaga.nvim"
        use "folke/lsp-trouble.nvim"

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use "nvim-telescope/telescope-fzy-native.nvim"

        -- Astronauta
        use "tjdevries/astronauta.nvim"

        -- Statusline
        use "hoob3rt/lualine.nvim"

        -- Misc UI
        use "glepnir/dashboard-nvim"
        use "folke/which-key.nvim"
        use "kyazdani42/nvim-web-devicons"

        -- QoL
        use "tpope/vim-commentary"
        use "tpope/vim-fugitive"

        -- Neoterm
        use "itmecho/neoterm.nvim"

        -- Dart
        use "dart-lang/dart-vim-plugin"

        -- Fish
        use "blankname/vim-fish"

        -- Color Schemes
        use {"dracula/vim", as = "dracula"}
        use "arcticicestudio/nord-vim"
        use "folke/tokyonight.nvim"
    end
)
