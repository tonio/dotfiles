#!/usr/bin/python
import re
import os
import sys
import base64
import urllib2, urllib
import subprocess
import json
from xml.dom import minidom

# keychain -----------------------------------------------------------------{{{
def get_keychain_pass(account=None, server=None):
    user = os.getlogin()
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': '/Users/%s/Library/Keychains/login.keychain' % user,
        'user': user
    }
    command = "sudo -u %(user)s %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True, stderr=subprocess.STDOUT)
    for line in p.stdout:
        if line.startswith('password: '):
            return re.match(r'password: "(.*)"', line).group(1)
    return ''
# }}}

# auth  --------------------------------------------------------------------{{{
u = 'antoine.abt@camptocamp.com'
u1 = (u, get_keychain_pass(u, 'www.google.com'))
u = 'antoine@abt.im'
u2 =  (u, get_keychain_pass(u, 'www.google.com'))
auth1 = base64.encodestring('%s:%s' % u1)[:-1]
auth2 = base64.encodestring('%s:%s' % u2)[:-1]
# }}}

if len(sys.argv)==1:
    sys.exit()

if sys.argv[1] == 'inbox':
    request = urllib2.Request('https://mail.google.com/mail/feed/atom')
    request.add_header('Authorization', 'Basic %s' % auth1)
    xml = minidom.parseString(urllib2.urlopen(request).read())
    unread = int(xml.getElementsByTagName('fullcount')[0].childNodes[0].nodeValue)
    color = 'colour239' if unread == 0 else 'white'
    count = 'colour235' if unread == 0 else 'magenta'

    f = open(os.path.join(os.path.expanduser('~'), '.unread'), 'w')
    f.write('#[fg=%s]inbox#[fg=colour235]/#[fg=%s]%d' % (color, count, unread))
    f.close()

if sys.argv[1] == 'other':
    request = urllib2.Request('https://mail.google.com/mail/feed/atom/dev')
    request.add_header('Authorization', 'Basic %s' % auth1)
    xml = minidom.parseString(urllib2.urlopen(request).read())
    unread = int(xml.getElementsByTagName('fullcount')[0].childNodes[0].nodeValue)
    color = 'colour239' if unread == 0 else 'white'
    count = 'colour235' if unread == 0 else 'green'

    f = open(os.path.join(os.path.expanduser('~'), '.unread_dev'), 'w')
    f.write('#[fg=%s]dev#[fg=colour235]/#[fg=%s]%d' % (color, count, unread))
    f.close()

    # Google Reader

    auth_url = 'https://www.google.com/accounts/ClientLogin'
    auth_req_data = urllib.urlencode({
        'Email': u2[0],
        'Passwd': u2[1],
        'service': 'reader'
        })
    auth_req = urllib2.Request(auth_url, data=auth_req_data)
    auth_resp = urllib2.urlopen(auth_req)
    auth_resp_content = auth_resp.read()
    auth_resp_dict = dict(x.split('=') for x in auth_resp_content.split('\n') if x)
    AUTH = auth_resp_dict["Auth"]

    # Create a cookie in the header using the Auth
    header = {'Authorization': 'GoogleLogin auth=%s' % AUTH}
    reader_base_url = 'http://www.google.com/reader/api/0/unread-count?%s'
    reader_req_data = urllib.urlencode({ 'all': 'true', 'output': 'json'})

    reader_url = reader_base_url % (reader_req_data)
    reader_req = urllib2.Request(reader_url, None, header)
    reader_resp = urllib2.urlopen(reader_req)
    reader_resp_content = reader_resp.read()
    j = json.loads(reader_resp_content)
    count = ([c['count'] for c in j['unreadcounts'] if c['id'].endswith('/state/com.google/reading-list')] or [0])[0]

    if count:
        content = '#[fg=white]rss#[fg=colour235]/#[fg=green]%d' % count
    else:
        content = '#[fg=colour239]rss#[fg=colour235]/#[fg=colour235]0'
    f = open(os.path.join(os.path.expanduser('~'), '.unread_reader'), 'w')
    f.write(content)
    f.close()
