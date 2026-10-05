# Install Rust (rustup)
[Rust Book](https://doc.rust-lang.org/book/ch01-01-installation.html)

`rustup` is installed by the Brewfile (`brew "rustup"`) and added to `PATH` in `.zshrc`. Install the stable toolchain:
```bash
rustup default stable
```

Do not use the `curl ... sh.rustup.rs` installer. It adds a second rustup in `~/.cargo/bin` and a `~/.cargo/env` line to `~/.zshenv` and `~/.profile`.
