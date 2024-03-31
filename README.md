<!--toc:start-->
- [Nerd Fonts](#nerd-fonts)
- [Kitty](#kitty)
- [Docker Image](#docker-image)
- [Neovim](#neovim)
- [ripgrep (move to dockervile)](#ripgrep-move-to-dockervile)
- [fd (move to dockerfile)](#fd-move-to-dockerfile)
- [SSH](#ssh)
- [Git](#git)
- [Lazygit](#lazygit)
- [Mason](#mason)
- [Lazyvim](#lazyvim)
  - [Extras](#extras)
  - [Updates](#updates)
  - [Neovim Setting](#neovim-setting)
  - [Linting](#linting)
<!--toc:end-->

# Nerd Fonts
* https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip

```zsh
./install-nerd-fonts.sh
```
# Kitty



# Docker Image
## Neovim
https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz
## ripgrep (move to dockervile)
```zsh
sudo ./install-ripgrep.sh
# not as root if it's installed somewere else than /usr/local/bin/
```

## fd (move to dockerfile)
```zsh
sudo ./install-fs.sh
# not as root if it's installed somewere else than /usr/local/bin/
#
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
git config --global user.name "Felix Langelier"
git config --global user.email sysadmin4j@users.noreply.github.com
cd ~/Repos/dotfiles/
git init
git checkout -b dev
git add README.md
git commit -m "firts draft"
git remote add origin git@github.com:sysadmin4j/dotfiles.git
git push origin dev
```

# Lazygit
# Mason
# Lazyvim


## Extras
markdown
## Updates
```vim
:lazy
:check
```


## Neovim Setting

See ~/.config/nvim/lua/config/options.lua

```lua
# Disable conceal
opt.conceallevel = 0
# TODO
# Diable mini.pairs
surounding insert behavior
```
## Linting
* https://www.josean.com/posts/neovim-linting-and-formatting
