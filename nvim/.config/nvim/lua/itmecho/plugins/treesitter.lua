return {
  'nvim-treesitter/nvim-treesitter',
  run = function(_, _, mode)
    if vim.fn.exists(':TSUpdate') == 2 then
      vim.cmd(':TSUpdate')
    end
  end,
  requires = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',
  },
  config = function()
    require('nvim-treesitter').setup()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'astro',
        'dockerfile',
        'fish',
        'go',
        'hcl',
        'html',
        'javascript',
        'lua',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'yaml',
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      playground = {
        enabled = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['iP'] = '@parameter.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['gsn'] = '@parameter.inner',
          },
          swap_previous = {
            ['gsp'] = '@parameter.inner',
          },
        },
      },
    })
    require('treesitter-context').setup({
      enable = true,
    })
  end,
}
