return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = true,
  keys = {
    { "<C-n>", ":Neotree filesystem reveal left<CR>", desc = "Open Neo-tree filesystem" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local ok, neotree = pcall(require, "neo-tree")
    if not ok then
      vim.notify("Failed to load neo-tree.nvim", vim.log.levels.ERROR)
      return
    end
    neotree.setup({
      filesystem = {
        follow_current_file = { enabled = true },
      },
    })
  end,
}
