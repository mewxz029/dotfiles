require "nvchad.mappings"

local map = vim.keymap.set

-- General Key Mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ft", ":TodoTelescope<CR>")

-- nvim-silicon Mappings
map("v", "<leader>sc", function()
  require("nvim-silicon").clip()
end, { desc = "Copy code screenshot to clipboard" })
map("v", "<leader>sf", function()
  require("nvim-silicon").file()
end, { desc = "Save code screenshot as file" })

-- Nvim DAP Mappings
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim Mappings
map("n", "<Leader>dtr", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables Rust" })

-- Copilot Chat Mappings
map("n", "<leader>ccq", function()
  local input = vim.fn.input "Quick Chat: "
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick Chat" })
map("n", "<leader>cco", vim.cmd.CopilotChatOpen, { desc = "CopilotChat - Open Chat" })
map("n", "<leader>ccmc", vim.cmd.CopilotChatModel, { desc = "CopilotChat - Show current model" })
map("n", "<leader>ccml", vim.cmd.CopilotChatModels, { desc = "CopilotChat - Model Lists" })
map("n", "<leader>cct", vim.cmd.CopilotChatTests, { desc = "CopilotChat - Generate Test for Code" })
map("v", "<leader>cce", vim.cmd.CopilotChatExplain, { desc = "CopilotChat - Explain Selected Code" })
map("v", "<leader>ccr", vim.cmd.CopilotChatReview, { desc = "CopilotChat - Review Selected Code" })
