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
      require "configs.lspconfig"
    end,
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "williamboman/mason.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function()
      -- ensure basic parser are installed
      local parsers =
        { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
      require("nvim-treesitter").install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

        -- enables treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require("nvim-treesitter").get_available()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require("nvim-treesitter").get_installed "parsers"

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require("nvim-treesitter").install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     "mason.nvim",
  --     "davidmh/cspell.nvim",
  --     "nvimtools/none-ls-extras.nvim",
  --     "nvim-lua/plenary.nvim",
  --     -- "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = function()
  --     local cspell = require "cspell"
  --     local ok, none_ls = pcall(require, "null-ls")
  --     if not ok then
  --       return
  --     end
  --
  --     local b = none_ls.builtins
  --
  --     local sources = {
  --       -- spell check
  --       b.diagnostics.codespell,
  --       -- cspell
  --       cspell.diagnostics.with {
  --         -- Set the severity to HINT for unknown words
  --         diagnostics_postprocess = function(diagnostic)
  --           diagnostic.severity = vim.diagnostic.severity["HINT"]
  --         end,
  --       },
  --       cspell.code_actions,
  --     }
  --     -- Define the debounce value
  --     local debounce_value = 200
  --     return {
  --       sources = sources,
  --       debounce = debounce_value,
  --       debug = true,
  --     }
  --   end,
  -- },
}
