return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = true,
  event = "BufReadPost",
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("Failed to load nvim-treesitter.configs", vim.log.levels.ERROR)
      return
    end
    configs.setup({
      ensure_installed = { "lua", "javascript", "rust", "c", "cpp", "python", "css", "html" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
