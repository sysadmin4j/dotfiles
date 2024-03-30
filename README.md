# Neovim
https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz

# Nerd Fonts
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip

```zsh
./install-nerd-fonts.sh
```
# Kitty
# Docker Image
# ripgrep
```zsh
sudo ./install-ripgrep.sh
not as root if it's installed somewere else than /usr/local/bin/
```

# fd ()

```zsh
sudo ./install-fs.sh
not as root if it's installed somewere else than /usr/local/bin/
```

# SSH

Create the ssh key for github

*  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key

```
# TODO specifiy file name in command
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
```

# Git

```zsh
git config --global user.name "Your Name"
git config --global user.email you@example.com
cd ~/Repos/dotfiles/
git init
git checkout -b dev
git add README.md
git commit -m "firts draft"
git remote add origin https://github.com/sysadmin4j/dotfiles.git
git push origin dev
```

# Lazygit


# Lazyvim


## Extras


#

## Updates
```vim
:lazy
:check
```


## Neovim Setting

```lua
# Disable conceal
opt.conceallevel = 0
# TODO
# Diable mini.pairs
surounding insert behavior
```
## Linting
* https://www.josean.com/posts/neovim-linting-and-formatting
