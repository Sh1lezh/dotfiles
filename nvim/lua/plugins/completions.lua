return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ok, luasnip = pcall(require, "luasnip")
      if ok then
        require("luasnip.loaders.from_vscode").lazy_load()
      else
        vim.notify("Failed to load LuaSnip", vim.log.levels.ERROR)
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local ok, cmp = pcall(require, "cmp")
      if not ok then
        vim.notify("Failed to load nvim-cmp", vim.log.levels.ERROR)
        return
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if luasnip_ok then
              luasnip.lsp_expand(args.body)
            end
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
      })
    end,
  },
}
