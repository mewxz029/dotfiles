# Mew's personal configuration.

## How to use this configuration on my machine?

Use [Chezmoi](https://www.chezmoi.io) to bootstrap this configuration on your machine: `sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply mewxz029`

## Personal vs work machine

`chezmoi init` asks whether this is the `personal` or `work` machine (stored in `~/.config/chezmoi/chezmoi.toml`, not in this repo). Templates use `.work` to switch:

- `Brewfile.tmpl` — personal-only and work-only apps.
- `dot_claude/private_settings.json.tmpl` — herdr hook added when `~/.claude/hooks/herdr-agent-state.sh` exists.

Machine-only files, never committed:

- `~/.zshrc.local` — sourced by `.zshrc` (work git identity aliases, secrets).
- `~/.config/chezmoi/claude-automode.json` — the `autoMode` object for Claude Code, inserted into `~/.claude/settings.json`. Claude Code only reads `autoMode` from user settings, so it can't live in a project `settings.local.json`.

# My Tools

- [Chezmoi](https://www.chezmoi.io) as dotfiles manager.

**Editor**

- [Neovim](https://neovim.io) as the primary editor on the command line.

  - [NVChad](https://nvchad.github.io) as primary neovim distribution.

**Shell**

- [Zsh](https://www.zsh.org/) as the primary shell.

- [Tmux](https://github.com/tmux/tmux) as the terminal multiplexer.

  - [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) as the plugin manager.

