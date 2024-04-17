# dotfiles

## Requirements

- docker-desktop ()
- kitty (Terminal)
- xQuartx (for the Clipboard, Browser preview)


## SSH

Create the ssh key for github

```zsh
# TODO specifiy file name in command
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
```

<https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>




## Nerd Fonts

```zsh
./install-nerd-fonts.sh


```

## Kitty

```zsh
./apply-kitty-config.sh


kitty -list-fonts
```

## zsh

```zsh
./apply-zsh-config.sh
```


## Neovim


```zsh
./docker-build.sh
./docker-run.sh
```

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
