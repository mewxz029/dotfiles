require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ft", ":TodoTelescope<CR>")

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })

map("v", "<leader>sc", function()
  require("nvim-silicon").clip()
end, { desc = "Copy code screenshot to clipboard" })
map("v", "<leader>sf", function()
  require("nvim-silicon").file()
end, { desc = "Save code screenshot as file" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
