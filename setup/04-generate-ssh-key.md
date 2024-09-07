# Generate SSH Key
## For GitHub
1. generate ssh key using `ssh-keygen`
```bash
$ ssh-keygen -t ed25519 -C "example@email.com"
```
2. add ssh key to ssh-agent
```bash
$ eval "$(ssh-agent -s)"
```
- first, check to see `~/.shh/config` file exists in default location
```bash
$ open ~/.ssh/config
> The file /Users/YOU/.ssh/config does not exist.
```
if the file doesn't exists, create file `~/.shh/config` the file and add this
```bash
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```
3. add ssh-key to ssh-agent
```$ ssh-add --apple-use-keychain /Users/mewxz029/.ssh/id_ed25519```

## For GitLab
1. generate ssh key using `ssh-keygen`
```bash
$ ssh-keygen -t ed25519 -C "example@email.com"
```
2. add ssh key to ssh-agent
```bash
$ eval "$(ssh-agent -s)"
```
- first, check to see `~/.shh/config` file exists in default location
```bash
$ open ~/.ssh/config
> The file /Users/YOU/.ssh/config does not exist.
```
if the file doesn't exists, create file `~/.shh/config` the file and add this
```bash
Host gitlab.com
  PreferredAuthentications publickey
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```
3. add ssh-key to ssh-agent
```$ ssh-add --apple-use-keychain /Users/mewxz029/.ssh/id_ed25519```
