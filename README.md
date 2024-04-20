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

Ref:

- <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>

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
# install the fonts "MesloLGL Nerd Font Mono" in the macOS user Library folder
./scripts/install-nerd-fonts.sh
```

## Kitty

```zsh
./scripts/apply-kitty-config.sh

# make sure the Nerd font is available for kitty
kitty +list-fonts | grep "MesloLGL Nerd Font Mono"
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

### Build

Don't forget to rebuild the ide docker image to apply Neovim configuration changes

```zsh
./scripts/docker-build-ide.sh
```

### Configuration

To reload a lua configuration within neovim

```nvim
:source %
```

See the config files:

- `~/.config/nvim/lua/config/options.lua`

### Usage

The following command will start a shell in the ide container.

#### without X11 (default)

```zsh
ide
```

#### with X11

```zsh
export IDE_X11=true; ide
```
