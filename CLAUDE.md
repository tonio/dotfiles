# Dotfiles

- `install.py` inits submodules and symlinks the entries of its `links` map
  into `~`, asking before replacing anything. A new dotfile must be added to
  that map. `.zshrc` and `.gitconfig` hardcode `~/.dotfiles`.
- Submodules: `zsh/antidote` (zsh plugins listed in `zsh/plugins.txt`) and
  `.tmux/fingers`.
- Neovim requires 0.12 and the tree-sitter CLI. Plugins are managed by
  `vim.pack`; commit `nvim/nvim-pack-lock.json` with any plugin change.
- When a mapping changes in `nvim/init.lua`, update `nvim/CHEATSHEET.md` and
  run `make` in `nvim/` to regenerate `CHEATSHEET.pdf`.
