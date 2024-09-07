# Install GVM (Go version manageer)
[gvm](https://github.com/moovweb/gvm)
1. Install [Bison](https://www.gnu.org/software/bison/)
> already in Brewfile

2. Install gvm
```
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```
Or if you are using zsh just change `bash` with `zsh`

# Mac OS X Requirements
- Install Mercurial from [https://www.mercurial-scm.org/downloads](https://www.mercurial-scm.org/downloads)
- Install Xcode Command Line Tools from the App Store.
```bash
xcode-select --install
brew update
brew install mercurial
```
