# dotfiles

Alacritty + Zellij + Neovim (LazyVim) setup.

## New machine

```sh
git clone git@github.com:v11g/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

[my-linux-playbook](https://github.com/v11g/my-linux-playbook) (private) runs this for you as one step of a full machine setup.

The script:

1. downloads zellij and neovim (pinned versions) into `~/.local/bin`
2. installs the MesloLGS Nerd Font into `~/.local/share/fonts`
3. symlinks `~/.config/{alacritty,zellij,nvim}` to this repo (existing dirs get backed up)
4. builds alacritty with cargo (needs rust and the apt deps it prints)
5. adds rust editor tooling (rust-analyzer, clippy, rustfmt) when rustup exists

It also adds a `dots` command: after changing any config, run `dots "what changed"` to commit and push. The playbook's daily timer also runs `dots` at 12:00.

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
