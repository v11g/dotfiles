# dotfiles

Alacritty + Zellij + Neovim (LazyVim) setup.

## New machine

```sh
git clone git@github.com:vukhanhtruong/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

The script:

1. downloads zellij and neovim (pinned versions) into `~/.local/bin`
2. installs the MesloLGS Nerd Font into `~/.local/share/fonts`
3. symlinks `~/.config/{alacritty,zellij,nvim}` to this repo (existing dirs get backed up)
4. builds alacritty with cargo (needs rust and the apt deps it prints)

Re-running is safe. To bump a version, change the number at the top of `install.sh`.

## Layout

| Folder | What |
|---|---|
| `alacritty/` | terminal config, tokyo-night colors |
| `zellij/` | config, keybinds, `sized` default layout (45/55 split), themes |
| `nvim/` | LazyVim config (see `nvim/README.md`) |
| `fonts/` | MesloLGS Nerd Font |

## Note

`alacritty/shared.toml` points the shell at `/home/linuxbrew/.linuxbrew/bin/zsh`. Change it if zsh lives elsewhere.
