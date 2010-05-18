#!/usr/bin/env python
import os, fnmatch, shutil

exclude = [ '*.sw*', '.git', 'install.*' ]

for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        path = '~/'+f
       # if isfile(path)
       #     os.remove('~/'+f)
       # if isdir(path)
       #     shutil.rmtree(path)
        os.symlink(f, path)
        print 'create link for %s' % (path)
