local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('Installing packer.nvim')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print('Enabling packer.nvim')
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  local use_file = function(name)
    use(require('itmecho.plugins.' .. name))
  end
  -- Packer
  use({ 'wbthomason/packer.nvim' })

  -- LSP
  use_file('lsp-setup')
  use({
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        timer = {
          fidget_decay = 10000,
        },
      })
    end,
  })
  use({
    'simrat39/symbols-outline.nvim',
    config = function()
      vim.g.symbols_outline = {
        auto_close = true,
        width = 25,
      }
    end,
  })
  use('nvim-lua/lsp_extensions.nvim')
  use({
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
    end,
  })
  use({
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        floating_window = false,
        hint_enable = true,
      })
    end,
  })
  use({
    'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init({ preset = 'codicons' })
    end,
  })
  use('stevearc/dressing.nvim')

  -- Completion
  use({
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/itmecho/snippets' })
    end,
  })
  use({ 'saadparwaiz1/cmp_luasnip', requires = { 'L3MON4D3/LuaSnip' } })
  use_file('cmp')

  use_file('null_ls')

  -- Navigation
  use({
    'ThePrimeagen/harpoon',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } },
    config = function()
      require('harpoon').setup({ global_settings = { enter_on_sendcmd = true } })
    end,
  })

  -- Notifications
  use({
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({ timeout = 2000 })
    end,
  })

  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
  })

  -- Treesitter
  use_file('treesitter')

  -- Telescope
  use_file('telescope')

  -- Statusline
  use_file('lualine')

  -- Git
  use({
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    config = function()
      require('neogit').setup({
        disable_commit_confirmation = true,
        integrations = { diffview = true },
      })
    end,
  })
  use('pwntester/octo.nvim')
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  })

  -- Misc UI
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        char = '|',
        buftype_exclude = { 'terminal' },
      })
    end,
  })
  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  })

  -- QoL
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  })

  -- Neoterm
  -- use "itmecho/neoterm.nvim"
  use('~/src/neoterm.nvim')

  -- Fish
  use('blankname/vim-fish')

  -- Kitty
  use('fladson/vim-kitty')

  -- Prettier
  use('prettier/vim-prettier')

  -- Rust
  use({
    'simrat39/rust-tools.nvim',
    config = function()
      require('rust-tools').setup({})
    end,
  })

  -- Color Schemes
  use({ 'dracula/vim', as = 'dracula' })
  use('shaunsingh/nord.nvim')
  use('folke/tokyonight.nvim')

  if packer_bootstrap then
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PackerComplete',
      callback = function()
        vim.cmd('colorscheme ' .. vim.env.THEME:lower())
      end,
      once = true,
    })
    require('packer').sync()
  else
    vim.cmd('colorscheme ' .. vim.env.THEME:lower())
  end
end)
