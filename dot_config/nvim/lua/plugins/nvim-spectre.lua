-- Find and Replace Across Files
return {
  "nvim-pack/nvim-spectre",
  cmd = { "Spectre" },
  config = function()
    require("spectre").setup {}
  end,
}
