#!/usr/bin/env python
import os, fnmatch, shutil

exclude = [ '*.sw*', '.git', 'install.*' ]

for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        path = os.path.join(os.path.expanduser('~'), f)
        if os.path.isfile(path) or os.path.isdir(path):
            os.unlink(path)
        os.symlink(os.path.abspath(f), path)
        print 'create link for %s' % (path)