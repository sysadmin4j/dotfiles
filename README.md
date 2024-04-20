# dotfiles

This is my configurations for a development environment in a docker container (fedora) running on macos.

## Requirements

- docker-desktop
- kitty (or any other OSC52 compliant terminal)
- xQuartx (for the Browser preview, avoid the buggy pasteboard)

Clipboard solution relying on OSC52
<https://neovim.io/doc/user/provider.html#clipboard-osc52>

## SSH

Create the ssh keys for github

```zsh
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
```

<https://docs.pcom/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>

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

```zsh
./scripts/apply-zsh-config.sh
```

## Neovim/LazyVim (whitin docker)

### Installation

```zsh
./scripts/install-ide.sh
```

### 

You can now use the ide command
```zsh
./docker-build.sh
./docker-run.sh
```


TODO:

## Markdown Preview

Make sure the command xdg-open (will need a browser like chrome or firefox)
Try worktree
vim motions?

## Lazyvim

## Extras

markdown


## Updates

## Neovim Setting

See ~/.config/nvim/lua/config/options.lua
