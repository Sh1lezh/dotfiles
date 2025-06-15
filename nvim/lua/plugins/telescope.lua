return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = true,
    keys = {
      { "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Live grep" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if not ok then
        vim.notify("Failed to load telescope.nvim", vim.log.levels.ERROR)
        return
      end

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      pcall(telescope.load_extension, "ui-select")
    end,
  },
}
