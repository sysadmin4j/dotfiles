# dotfiles

My configuration files and scripts for a Neovim/LazyVim integrated development environment in a docker container (fedora).

- Clipboard solution relying on OSC52
  - [neovim clipboard-osc52 documentation](https://neovim.io/doc/user/provider.html#clipboard-osc52)
- UI solution based on X11, mainly used for browser preview using xdg-open under the hood
- Install and configure everything as a non-root user
- Tested on macOS Sonoma

## Requirements

- Docker
- Kitty (or any OSC52 compliant terminal)
  - [OSC52 supported terminal list](https://github.com/ojroques/vim-oscyank)
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

Install the fonts *MesloLGL Nerd Font Mono* in the macOS user Library folder

```zsh
./scripts/install-nerd-fonts.sh
```

## Kitty


```zsh
./scripts/apply-kitty-config.sh
```

Make sure the Nerd font is available for kitty

```zsh
kitty +list-fonts | grep "MesloLGL Nerd Font Mono"
```

## Zsh

- share history between host and container (docker volumes)
- script `.scripts/apply-zsh-config.sh` to complete

```zsh
./scripts/apply-zsh-config.sh
```

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

| ENV | Default value *(in ./scripts/docker-build-ide.sh)* |  Description |
| -------------- | -------------- | --------------- |
| IDE_USERNAME | felix | username of the docker image non-root user |
| IDE_GROUPNAME | staff | groupname of the docker image non-root user |
| IDE_UID | 501 | uid of the docker image non-root user, **must match the uid of the user running the ide command on the docker host** |
| IDE_GID | 20 | gid of the docker image non-root user, **must match the primary gid of the user running the ide command on the docker host** |

### Configuration

To reload a lua configuration within neovim

```nvim
:source %
```

See the config files:

- `~/.config/nvim/lua/config/options.lua`

### Usage

| ENV | Default value *(in ./scripts/docker-run-ide.sh)* | Description |
| -------------- | -------------- | --------------- |
| IDE_IMAGE_NAME | ide | image name to use|
| IDE_IMAGE_VERISON | latest | image version to use |
| IDE_X11 | false | start a x11 session, used mainly for browser preview *`<Leader>cp`* |
| IDE_DEBUG | false | print debug messages at the console |

The following command will start a shell in the ide container.

#### without X11 (default)

```zsh
ide
```

#### with X11

```zsh
export IDE_X11=true; ide
```
