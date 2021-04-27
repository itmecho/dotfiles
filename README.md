# Dotfiles

# Setup

1. Clone this repository somewhere in your home folder. I use `~/.dotfiles`

```sh
git clone https://github.com/itmecho/dotfiles ~/.dotfiles
```

2. Symlink config files for each application using `stow`. I prefer to remove any existing files so that the whole folder will get symlinked

```sh
cd ~/.dotfiles
stow alacritty # for example
```
