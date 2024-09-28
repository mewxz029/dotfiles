return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  opts = {
    -- Configuration here, or leave empty to use defaults
    font = "JetBrainsMono Nerd Font Mono",
    theme = "Dracula",
    line_offset = function(args)
      return args.line1
    end,
  },
}
