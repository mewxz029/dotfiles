local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = {
      "eslint_d",
      "prettierd",
      "prettier",
      stop_after_first = true,
    },
    javascript = {
      "eslint_d",
      "prettierd",
      "prettier",
      stop_after_first = true,
    },
    vue = {
      "eslint_d",
      "prettierd",
      "prettier",
      stop_after_first = true,
    },
    json = { "prettier" },
    go = { "gofumpt", "goimports-reviser", "golines" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    eslint_d = {
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
        async = true,
      },
    },
  },
}

require("conform").setup(options)
