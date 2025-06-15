return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ok, lualine = pcall(require, "lualine")
    if not ok then
      vim.notify("Failed to load lualine.nvim", vim.log.levels.ERROR)
      return
    end

    lualine.setup({
      options = {
        theme = "dracula", 
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
