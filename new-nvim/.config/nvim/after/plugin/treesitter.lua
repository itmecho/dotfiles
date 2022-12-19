if PluginLoaded('nvim-treesitter') then
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "help",
      "lua",
      "go",
      "rust",
      "javascript",
      "typescript",
      "svelte",
      "markdown",
      "norg",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end
