return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      -- Adapters
      -- C, C++, Rust
      local codelldb = require("mason-registry").get_package("codelldb"):get_install_path() .. "/codelldb"
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          targetArchitecture = "arm64",
        },
      }
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
