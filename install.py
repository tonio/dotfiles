#!/usr/bin/env python3
import os
import shutil
import subprocess

repo = os.path.dirname(os.path.abspath(__file__))
home = os.path.expanduser('~')

links = {
    '.bashrc': '.bashrc',
    '.bin': '.bin',
    '.gitconfig': '.gitconfig',
    '.global_gitignore': '.global_gitignore',
    '.pystartup': '.pystartup',
    '.tmux': '.tmux',
    '.tmux.conf': '.tmux.conf',
    '.zshrc': '.zshrc',
    'nvim': '.config/nvim',
}

subprocess.run(['git', '-C', repo, 'submodule', 'update', '--init'], check=True)

for src, dest in links.items():
    src = os.path.join(repo, src)
    path = os.path.join(home, dest)
    if os.path.islink(path) and os.path.realpath(path) == os.path.realpath(src):
        continue
    if os.path.lexists(path):
        if input('replace %s? [y/N] ' % path).strip().lower() != 'y':
            continue
        if os.path.isdir(path) and not os.path.islink(path):
            shutil.rmtree(path)
        else:
            os.unlink(path)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    os.symlink(src, path)
    print('create link for %s' % path)
