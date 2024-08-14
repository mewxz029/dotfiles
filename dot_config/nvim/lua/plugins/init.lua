return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "prettierd",
        "eslint_d",
        "typescript-language-server",
        "tailwindcss-language-server",
        "vue-language-server",
        "eslint-lsp",
        "codespell",
        "cspell",
        "gopls",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "json",
        "go",
        "vue",
        "jsdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim", "davidmh/cspell.nvim", "nvimtools/none-ls-extras.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local cspell = require "cspell"
      local ok, none_ls = pcall(require, "null-ls")
      if not ok then
        return
      end

      local b = none_ls.builtins

      local sources = {
        -- spell check
        b.diagnostics.codespell,
        -- cspell
        cspell.diagnostics.with {
          -- Set the severity to HINT for unknown words
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["HINT"]
          end,
        },
        cspell.code_actions,
      }
      -- Define the debounce value
      local debounce_value = 200
      return {
        sources = sources,
        debounce = debounce_value,
        debug = true,
      }
    end,
  },
}
