# Neovim Config (`~/.config/nvim`)

## Framework

- **NvChad v2.5** with lazy.nvim plugin manager
- Base46 for themes (Catppuccin with transparency)
- Tree-sitter parsers auto-install on first use

## Code Formatting

| Language | Formatter |
|----------|-----------|
| Lua | stylua (`.stylua.toml`: 120 col, 2-space indent, double quotes) |
| JS/TS/Vue | eslint_d → prettierd → prettier |
| CSS/HTML/JSON | prettier |
| Go | gofumpt → goimports-reviser → golines |

Formatter config: `lua/configs/conform.lua`

## Linting

- `cspell.json` dictionary exists (Thai chars ignored, `folke`/`codespell`/`tailwindcss`/`nvim` whitelisted) but is not currently wired up — no plugin consumes it. Spell checking is not active.

## LSP & Mason

LSP servers installed via Mason (`lua/chadrc.lua:mason.pkgs`):
`lua-language-server`, `html-lsp`, `css-lsp`, `prettier`, `prettierd`, `eslint_d`, `tailwindcss-language-server`, `vue-language-server`, `eslint-lsp`, `gopls`, `rust-analyzer`, `codelldb`, `vtsls`, `json-lsp`, `oxlint`, `oxfmt`, `codebook`, `prisma-language-server`

LSP config: `lua/configs/lspconfig.lua`
Custom LSP configs: `lua/lsp/` (vtsls, vue_ls, prismals)

## Debugging (DAP)

- **Rust**: rustaceanvim + codelldb (Mason package at `$MASON/packages/codelldb`)
- **Go**: nvim-dap + delve
- Dap keymaps: `<Leader>dl/dj/dk/dc>/db/dd/de/dr` (step into/over/out/continue/breakpoint/conditional/terminate/run_last)
- DapUI auto-opens on attach, closes on terminate

## Key Conventions

- Leader key: `<Space>`
- Custom mappings in `lua/mappings.lua`
- Keymap pattern: most keymaps centralized in `lua/mappings.lua`; plugins that need lazy-load-on-keypress (e.g. `flash-nvim.lua`) declare their own `keys = {...}` in the plugin spec instead — both are intentional, not inconsistent
- Plugin specs in `lua/plugins/` (one file per plugin/group)
- Plugin config modules in `lua/configs/`
- Theme/custom NvChad overrides in `lua/chadrc.lua`
- `<Leader>ft` → TodoTelescope, `<Leader>st` → Spectre, `<Leader>tt` → Trouble

## File Structure

```
init.lua           # Entry point, bootstraps lazy.nvim
lua/
  chadrc.lua       # NvChad theme, UI, Mason packages
  options.lua     # Neovim options (extends nvchad.options)
  mappings.lua    # Custom keymaps
  plugins/        # One file per plugin or plugin group
  configs/        # Plugin configuration modules
  lsp/            # LSP server configs (vtsls, vue_ls)
```
