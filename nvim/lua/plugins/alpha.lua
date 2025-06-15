return {
  "goolord/alpha-nvim",
  lazy = true,
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local ok, alpha = pcall(require, "alpha")
    if not ok then
      vim.notify("Failed to load alpha-nvim", vim.log.levels.ERROR)
      return
    end

    local ok_dashboard, dashboard = pcall(require, "alpha.themes.startify")
    if not ok_dashboard then
      vim.notify("Failed to load alpha.themes.startify", vim.log.levels.ERROR)
      return
    end

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    alpha.setup(dashboard.opts)
  end,
}
