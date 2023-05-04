return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>pb",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "Switch to project",
      },
      { "<leader>ff", require("lazyvim.util").telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", require("lazyvim.util").telescope("files"), desc = "Find Files (root dir)" },
    },
  },
}
