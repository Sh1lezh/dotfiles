return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Ensure the theme loads immediately
  priority = 1000,
  config = function()
    local ok, _ = pcall(vim.cmd.colorscheme, "catppuccin-mocha")
    if not ok then
      vim.notify("Failed to load catppuccin-mocha colorscheme", vim.log.levels.ERROR)
    end
  end,
}
