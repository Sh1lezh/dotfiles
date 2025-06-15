return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      local ok, mason = pcall(require, "mason")
      if not ok then
        vim.notify("Failed to load mason.nvim", vim.log.levels.ERROR)
        return
      end
      mason.setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    event = "BufReadPre",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
      if not ok then
        vim.notify("Failed to load mason-lspconfig.nvim", vim.log.levels.ERROR)
        return
      end
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "clangd", "zls", "rust_analyzer", "ts_ls", "pyright" },
      })

      local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_ok then
        vim.notify("Failed to load nvim-lspconfig", vim.log.levels.ERROR)
        return
      end

      
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            local server_config = {
              capabilities = capabilities,
            }
            if server_name == "lua_ls" then
              server_config.settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" }, 
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                },
              }
            elseif server_name == "pyright" then
              server_config.settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              }
            end
            lspconfig[server_name].setup(server_config)
          end,
        })
      else
        
        local servers = { "lua_ls", "clangd", "zls", "rust_analyzer", "ts_ls", "pyright" }
        for _, server in ipairs(servers) do
          local server_config = {
            capabilities = capabilities,
          }
          if server == "lua_ls" then
            server_config.settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
              },
            }
          elseif server == "pyright" then
            server_config.settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            }
          end
          lspconfig[server].setup(server_config)
        end
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "LspAttach",
    config = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}
