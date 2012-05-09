#!/usr/bin/env python
# coding=UTF-8

import math, subprocess

p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0]

o_max = [l for l in output.splitlines() if 'MaxCapacity' in l][0]
o_cur = [l for l in output.splitlines() if 'CurrentCapacity' in l][0]

b_max = float(o_max.rpartition('=')[-1].strip())
b_cur = float(o_cur.rpartition('=')[-1].strip())

charge = b_cur / b_max
c = int(math.ceil(5 * charge))

# Output

if c == 1: out = u'○'
if c == 2: out = u'◔'
if c == 3: out = u'◑'
if c == 4: out = u'◕'
if c == 5: out = u'●'
out = out.encode('utf-8')
import sys

color_green = 'green'
color_yellow = 'yellow'
color_red = 'red'
color_out = (
    color_green if c > 3
    else color_yellow if c > 1
    else color_red
)

out = '#[fg=%s]%s' % (color_out, out)
sys.stdout.write(out)
