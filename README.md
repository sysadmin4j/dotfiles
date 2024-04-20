# dotfiles

My configuration files and scripts for a Neovim/LazyVim integrated development environment in a docker container (fedora).

- Clipboard solution relying on OSC52

<https://neovim.io/doc/user/provider.html#clipboard-osc52>

- UI solution based on X11, mainly used for browser preview using xdg-open under the hood

- Install and configure everything as a non-root user

- Tested on macOS Sonoma

## Requirements

- Docker
- Kitty (or any OSC52 compliant terminal)
- xQuartz (or any X11 server)

## SSH

Create the ssh keys for github

```zsh
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
```

<https://docs.pcom/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>

TODO:

- remove the usage of macos keychain, or check if it's possible to use within a docker container
- try worktree

## Git

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

## GPG

TODO:

## Nerd Fonts

```zsh
# install the fonts "Meslo Nerd" in the macos user Library folder
./scripts/install-nerd-fonts.sh
```

## Kitty

```zsh
# and starting session
./scripts/apply-kitty-config.sh

# make sure the nerd font is available for kitty
kitty -list-fonts
```

## Zsh

Copy the .zshrc file to your home directory

TODO:

- install powerlevel 10k
- share history between host and container (docker volumes)
- script `.scripts/apply-zsh-config.sh` to complete

## Neovim/LazyVim (within docker)

### Installation

```zsh
./scripts/install-ide.sh
```

### Configuration

```nvim
:source %
```

See ~/.config/nvim/lua/config/options.lua

### Usage

with X11

without X11 (default)

```zsh
```
