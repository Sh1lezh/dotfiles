local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local ok, result = pcall(vim.fn.system, {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if not ok or vim.v.shell_error ~= 0 then
    vim.notify("Failed to clone lazy.nvim: " .. (result or "unknown error"), vim.log.levels.ERROR)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
  performance = {
    rtp = {
      disabled_plugins = { "netrw", "netrwPlugin" }, 
    },
  },
  ui = {
    border = "rounded", 
  },
}

local ok, lazy = pcall(require, "lazy")
if ok then
  lazy.setup("plugins", opts)
else
  vim.notify("Failed to load lazy.nvim", vim.log.levels.ERROR)
end

pcall(require, "vim-options")
