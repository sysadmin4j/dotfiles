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

## Kitty

```zsh
kitty -list-fonts
```

```zsh
:
```

## Docker Image

test

## Requirements

- xQuartx (for the Clipboard)

## Helpers

```zsh
./docker-build.sh
./docker-run.sh
```

## Clipboard

Put a little diagram here! xclip with x11 and docker.

## SSH

Create the ssh key for github

*  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key

```zsh
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

## GPG

## Markdown Preview

Make sure the command xdg-open (will need a browser like chrome or firefox)
Try worktree
vim motions?

## Lazygit

To practive

## Mason

To explore

## Lazyvim

## Extras

markdown

## Updates

```vim
:lazy
:check
```


## Neovim Setting

See ~/.config/nvim/lua/config/options.lua


# TODO
# Dia

## Linting

- [https://www.josean.com/posts/neovim-linting-and-formatting]

# Bugs and Errors
## When switching from to macos to alpine (docker image), telescope needs to be reinstalled with Lazy.

```nvim
  Error  15:05:02 notify.error lazy.nvim Failed to run `config` for telescope-fzf-native.nvim

...m/lazy/telescope.nvim/lua/telescope/_extensions/init.lua:10: 'fzf' extension doesn't exist or isn't installed: ...hare/nvim/lazy/telescope-fzf-native.nvim/lua/fzf_lib.lua:11: dlopen(/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so, 0x0005): tried: '/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so' (not a mach-o file), '/System/Volumes/Preboot/Cryptexes/OS/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so' (no such file), '/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/lua/../build/libfzf.so' (not a mach-o file), '/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so' (not a mach-o file), '/System/Volumes/Preboot/Cryptexes/OS/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so' (no such file), '/Users/felix/.local/share/nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so' (not a mach-o file)

# stacktrace:
  - /telescope.nvim/lua/telescope/_extensions/init.lua:10 _in_ **load_extension**
  - /telescope.nvim/lua/telescope/_extensions/init.lua:62 _in_ **load_extension**
  - /LazyVim/lua/lazyvim/plugins/editor.lua:138 _in_ **fn**
  - /LazyVim/lua/lazyvim/util/init.lua:134 _in_ **on_load**
  - /LazyVim/lua/lazyvim/plugins/editor.lua:137 _in_ **config**
```

## Tree-sitte-cli when installed with npm install -g, needs to be installed with apk (alpine package manager). 

```nvim
Error: spawn /usr/local/lib/node_modules/tree-sitter-cli/tree-sitter ENOENT
    at ChildProcess._handle.onexit (node:internal/child_process:286:19)
    at onErrorNT (node:internal/child_process:484:16)
    at process.processTicksAndRejections (node:internal/process/task_queues:82:21)
Emitted 'error' event on ChildProcess instance at:
    at ChildProcess._handle.onexit (node:internal/child_process:292:12)
    at onErrorNT (node:internal/child_process:484:16)
    at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'spawn /usr/local/lib/node_modules/tree-sitter-cli/tree-sitter',
  path: '/usr/local/lib/node_modules/tree-sitter-cli/tree-sitter',
  spawnargs: [ '-V' ]
}

Node.js v20.11.1
```

## Mason and gcompat
[https://github.com/williamboman/mason.nvim/issues/995]

```nvim
:MasonInstall --target=linux_x64_gnu lua-language-server
```
