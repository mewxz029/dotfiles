# Install runtimes with mise
[mise](https://mise.jdx.dev) manages language runtime versions. It replaces nvm and gvm.

1. `mise` is installed by the Brewfile and activated in `.zshrc`.
2. Install the global tools listed in `~/.config/mise/config.toml` (managed by chezmoi):
```bash
mise install
```
3. Use a different version in one project:
```bash
cd my-project
mise use node@18   # writes mise.toml in the project
```

Go comes from Homebrew (`brew "go"`), not mise.
