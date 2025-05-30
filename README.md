# dotfiles

My configuration files and scripts for a Neovim/LazyVim integrated development environment in a docker container (fedora).

- Clipboard solution relying on OSC52
  - [neovim clipboard-osc52 documentation](https://neovim.io/doc/user/provider.html#clipboard-osc52)
- UI solution based on X11, mainly used for browser preview using xdg-open under the hood
- Install and configure everything as a non-root user
- Docker in Docker (dnd)
- Tested on macOS Sonoma and Sequoia

## Requirements

- Docker
- Kitty or Ghostty (or any OSC52 compliant terminal)
  - [OSC52 supported terminal list](https://github.com/ojroques/vim-oscyank)
- xQuartz (or any X11 server)

## SSH

Create your ssh keys

```zsh
felix@macos ~ % ssh-keygen -t ed25519 -C "your_email@example.com"
felix@macos ~ % ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Test your github access

```zsh
felix@macos ~ % ssh -T git@github.com
Hi sysadmin4j! You've successfully authenticated, but GitHub does not provide shell access.
```

Make sure the ssh-agent is used

```zsh
felix@macos ~ % ssh-add -l
256 SHA256:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX your_email@example.com (ED25519)
```

Ref:

- [Github documentation - Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

## Git

Setting up the git config `~/.gitconfig`, creating the `IDE_WORKSPACE` folder, and cloning the dotfiles repository

```zsh
felix@macos ~ % git config --global user.name "Mona Lisa"
felix@macos ~ % git config --global user.email USERNAME@users.noreply.github.com
felix@macos ~ % mkdir Repos
felix@macos ~ % cd Repos
felix@macos Repos % git clone git@github.com:sysadmin4j/dotfiles.git
felix@macos Repos % cd dotfiles
felix@macos dotfiles % git status
```

Ref:

- [Github documentation - Setting your username in Git](https://docs.github.com/en/get-started/getting-started-with-git/setting-your-username-in-git)
- [Github documentation - Setting your commit email address](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)

### GPG

```zsh
TODO
```

Ref:

- [Github documentation - Generating a new GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
- [Github documentation - Telling Git about your signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)

## Nerd Fonts

Install the fonts *MesloLGL Nerd Font Mono* in the macOS user Library folder

```zsh
felix@macos dotfiles % ./scripts/install-nerd-fonts.sh
```

The script [test-fonts.sh](https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/bin/scripts/test-fonts.sh) can be usefull to test your fonts installation in the ide container we will use later on

## Kitty

Apply the Kitty configuration `~/.config/kitty/kitty.conf` as well as the startup session configuration `~/.config/kitty/startup.session` on the masOS host

```zsh
felix@macos dotfiles % ./scripts/apply-kitty-config.sh
```

Make sure the Nerd font is available for kitty

```zsh
felix@macos ~ % kitty +list-fonts | grep "MesloLGL Nerd Font Mono"
```

## Zsh

The following script will create the folder `~/.local/state/zsh` used to share the `.zsh_history` file and copy the `.zshrc.macos` to `~/.zshrc` on the macOS host

```zsh
felix@macos dotfiles % ./scripts/apply-zsh-config.sh
```

## Neovim/LazyVim (within docker)

### Installation

The following script will simply copy the script `./scripts/docker-run-ide.sh` to `~/.local/bin/ide` on the macOS host so you can use the `ide` command

```zsh
felix@macos dotfiles % ./scripts/install-ide.sh
```

Note: You can also use the `install-ide` alias


### Build

Don't forget to rebuild the ide docker image to apply Neovim configuration changes

```zsh
felix@macos dotfiles % ./scripts/docker-build-ide.sh
```

Note: You can also use the `build-ide` alias

| ENV | Default value *(in ./scripts/docker-build-ide.sh)* |  Description |
| -------------- | -------------- | --------------- |
| IDE_USERNAME | felix | username of the docker image non-root user |
| IDE_GROUPNAME | staff | groupname of the docker image non-root user |
| IDE_UID | 501 | uid of the docker image non-root user, **must match the uid of the user running the ide command on the docker host** |
| IDE_GID | 20 | gid of the docker image non-root user, **must match the primary gid of the user running the ide command on the docker host** |
| IDE_HOME_DIR | /Users/${IDE_USERNAME} | home directory of the docker image non-root user, **must match the your $HOME folder of the user runnung the ide command on the docker host** |

### Configuration


To find the loaded LazyVim configuration within neovim

```nvim
<Leader>fc
```

To reload the current lua configuration within neovim

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
| IDE_WORKSPACE | ${HOME}/Repos | your workspace directory, the location of your git repositories |

The following command will start a shell in the ide container.

#### without X11 (default)

```zsh
ide
```

#### with X11

```zsh
export IDE_X11=true; ide
```
