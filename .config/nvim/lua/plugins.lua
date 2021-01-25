vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
    -- " LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/lsp_extensions.nvim'

    use 'vim-airline/vim-airline'
    use 'airblade/vim-rooter'
    use 'tpope/vim-commentary'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'itmecho/bufterm.nvim'
    use '~/src/personal/lens.nvim'

    -- " Language plugins
	use 'sheerun/vim-polyglot'

    -- " Color Schemes
    use { 'dracula/vim', as = 'dracula' }
    use 'arcticicestudio/nord-vim'
end)
