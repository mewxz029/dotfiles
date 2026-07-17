require("nvchad.configs.lspconfig").defaults()

local vtslsConfig = require "lsp.vtsls"
vim.lsp.config("vtsls", vtslsConfig)
vim.lsp.enable "vtsls"

local vueLsConfig = require "lsp.vue_ls"
vim.lsp.config("vue_ls", vueLsConfig)
vim.lsp.enable "vue_ls"

local prismaLsConfig = require "lsp.prismals"
vim.lsp.config("prismals", prismaLsConfig)
vim.lsp.enable "prismals"

local servers = { "html", "cssls", "tailwindcss", "gopls", "jsonls", "codebook", "oxlint", "eslint" }

for _, name in ipairs(servers) do
  vim.lsp.enable(name)
end
