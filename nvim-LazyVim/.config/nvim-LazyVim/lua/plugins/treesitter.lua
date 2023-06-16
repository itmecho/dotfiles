return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ignore_install = { "help" }
    end,
  },
  { 'nvim-treesitter/playground' }
}
