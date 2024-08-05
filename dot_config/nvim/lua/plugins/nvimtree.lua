return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      local config = require "nvchad.configs.nvimtree"

      config.filters = {
        dotfiles = false,
      }

      config.git = {
        ignore = false,
      }

      config.actions = {
        open_file = {
          resize_window = false,
        },
      }

      return config
    end,
  },
}
