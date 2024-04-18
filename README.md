# dotfiles
My Linux dotfiles, manageable with GNU Stow:
```sh
sudo apt install stow
cd
git clone git@github.com:DestopLine/dotfiles.git
cd dotfiles
stow .
```
NOTE: `.bashrc` (or other files) might already exist, to avoid stow aborting, either remove the files:
```sh
cd
rm .bashrc
cd dotfiles
stow .
```
or use adopt and restore:
```sh
stow --adopt .
git restore .
```

## Neovim
My neovim config can be found [here](https://github.com/DestopLine/nvim).
