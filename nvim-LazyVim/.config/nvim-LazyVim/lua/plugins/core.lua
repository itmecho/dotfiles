return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
      defaults = {
        keymaps = false,
      },
    },
  },
  { "alpha-nvim",       enabled = false },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    config = function()
      local path = '~/.config/' .. vim.env.NVIM_APPNAME .. '/lua/snippets'
      print(path)
      require('luasnip.loaders.from_lua').load({ paths = { path } })
    end,
    keys = function()
      return {}
    end,
  },
  { "mini.pairs",       enabled = false },
  { "mini.indentscope", enabled = false },
}
