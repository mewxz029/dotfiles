local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = {
      -- { "prettierd", "prettier" },
      "eslint_d",
    },
    javascript = {
      { "prettierd", "prettier" },
      "eslint_d",
    },
    vue = {
      { "prettierd", "prettier" },
      "eslint_d",
    },
    json = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
