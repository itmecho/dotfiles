return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local lsp = require('lsp-zero')
    lsp.preset('recommended')

    lsp.ensure_installed({
      'tsserver',
      'sumneko_lua',
      'gopls',
      'rust_analyzer',
    })

    lsp.configure('tsserver', {
      flags = {
        debounce_text_changes = 300,
      },
    })

    lsp.nvim_workspace()

    lsp.on_attach(function(client, bufnr)
      if client.name ~= 'null-ls' then
        client.server_capabilities.documentFormattingProvider = false
      end
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gT', '<cmd>Telescope lsp_type_definitions<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
      vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', opts)
      vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gs', '<cmd>Telescope lsp_document_symbols<cr>', opts)
      vim.keymap.set('n', 'gS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)
      vim.keymap.set('n', 'gx', '<cmd>LspRestart<cr>', opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next({wrap = true})<CR>')
      vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', '<leader>F', vim.cmd.LspZeroFormat)
    end)

    lsp.setup()
  end
}
