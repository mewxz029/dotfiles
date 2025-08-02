local configs = require "nvchad.configs.lspconfig"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }

  local clients = vim.lsp.get_clients { name = "ts_ls" }
  if #clients == 0 then
    vim.notify("No ts_ls client found", vim.log.levels.ERROR)
    return
  end
  local client = clients[1]
  client:exec_cmd(params)
  vim.notify("Imports sorted", vim.log.levels.INFO)
end

local function rename_file()
  local source_file, target_file

  vim.ui.input({
    prompt = "Source : ",
    completion = "file",
    default = vim.api.nvim_buf_get_name(0),
  }, function(input)
    source_file = input
  end)
  vim.ui.input({
    prompt = "Target : ",
    completion = "file",
    default = source_file,
  }, function(input)
    target_file = input
  end)

  local params = {
    command = "_typescript.applyRenameFile",
    arguments = {
      {
        sourceUri = source_file,
        targetUri = target_file,
      },
    },
    title = "",
  }

  vim.lsp.util.rename(source_file, target_file)
  local clients = vim.lsp.get_clients { name = "ts_ls" }
  if #clients == 0 then
    vim.notify("No ts_ls client found", vim.log.levels.ERROR)
    return
  end
  local client = clients[1]
  client:exec_cmd(params)
  vim.notify("Rename files", vim.log.levels.INFO)
end

local util = require "lspconfig/util"
local vue_language_server_path = vim.fn.expand "$MASON/packages/vue-language-server"
  .. "/node_modules/@vue/language-server"

local servers = {
  html = {},
  cssls = {},

  ts_ls = {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
      RenameFile = {
        rename_file,
        description = "Rename File",
      },
    },
    filetypes = { "javascript", "typescript", "vue", "typescriptreact", "typescript.tsx" },
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
  },

  volar = {
    -- init_options = {
    --   vue = {
    --     hybridMode = false,
    --   },
    -- },
  },
  eslint = {},
  tailwindcss = {
    autostart = true,
    filetypes = { "html", "vue" },
  },
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
