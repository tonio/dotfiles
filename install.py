#!/usr/bin/env python
import os
import fnmatch
import shutil

exclude = [ '*.sw*', '*.un~', '.git*', 'install.*' ]
home = os.path.expanduser('~')

def gen_gitconfig():
    gh_config = '\n'
    gh_path = os.path.join(home, '.githubconfig')
    if os.path.isfile(gh_path):
        f = open(gh_path)
        gh_config += f.read()
        f.close()
    else:
        f = open('.githubconfig')
        gh_config = f.read()
        f.close()
        # ask for github token or we could use
        # https://github.com/radar/github-token-fetcher
        # to retrieve it (but it's ruby)
        token = raw_input('What is your github token? ').strip()
        if token:
            # cache .githubconfig only if a token has been given
            gh_config += '    token = %s' % token
            print 'cache %s' % gh_path
            f = open(gh_path, 'w')
            f.write(gh_config)
            f.close()

    g_path = os.path.join(home, '.gitconfig')
    shutil.copy('.gitconfig', g_path)
    print 'generate %s' % g_path
    f = open(g_path, 'a')
    f.write(gh_config)
    f.close()



for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        path = os.path.join(home, f)
        if os.path.isfile(path) or os.path.islink(path):
            os.unlink(path)
        elif os.path.isdir(path):
            shutil.rmtree(path)
        os.symlink(os.path.abspath(f), path)
        print 'create link for %s' % (path)
gen_gitconfig()
