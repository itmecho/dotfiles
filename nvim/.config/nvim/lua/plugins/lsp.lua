return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      require('luasnip.loaders.from_lua').load({ paths = { '~/.config/nvim/lua/itmecho/snippets' } })

      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(_, bufnr)
        vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', { buffer = bufnr })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set('n', '<leader>cs', '<cmd>Telescope lsp_document_symbols<cr>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>ct', '<cmd>Telescope lsp_type_definitions<cr>', { buffer = bufnr })
      end)

      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
      lspconfig.ocamllsp.setup({})
      lspconfig.clangd.setup({})

      lspconfig.stylelint_lsp.setup({
        filetypes = { 'css' },
      })
      lspconfig.cssmodules_ls.setup({
        on_attach = function(client)
          -- avoid accepting `definitionProvider` responses from this LSP
          client.server_capabilities.definitionProvider = false
        end,
        init_options = {
          camelCase = 'false',
        },
      })
      lsp.setup()

      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
  { 'j-hui/fidget.nvim', config = true },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      mode = 'document_diagnostics',
      height = 15,
    },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', 'Document diagnostics' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace diagnostics' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', 'Trouble Quickfix' },
    },
  },
}
