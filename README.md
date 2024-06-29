# dotfiles
My Linux dotfiles, manageable with GNU Stow:
```sh
sudo apt install stow
cd
git clone git@github.com:DestopLine/dotfiles.git
cd dotfiles
stow i3 zsh  # stow i3 and zsh related packages
stow */      # OR stow everything
```
NOTE: `.bashrc` (or other files) might already exist, to avoid stow aborting, either remove the files:
```sh
rm ~/.bashrc
stow bash
```
or use adopt and restore:
```sh
stow --adopt bash
git restore bash
```

## Neovim
My neovim config can be found [here](https://github.com/DestopLine/nvim).
