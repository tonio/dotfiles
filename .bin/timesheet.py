#!/usr/bin/env python
# coding: utf-8
from datetime import datetime, timedelta
import sys
# virtualenv ... && pip install ERPpeek
import erppeek
from time import sleep
import codecs
import getpass
import os
import argparse

def get_monday():
    dt = datetime.now()
    return (dt - timedelta(days=dt.weekday())).strftime('%Y-%m-%d')

parser = argparse.ArgumentParser(description='Display timesheet remaining time')
parser.add_argument('--progress', action='store_true', help='display progress bar')

args = parser.parse_args()

login = os.getenv('USER')
password = os.getenv('ODOO_PASSWORD', None)
if password is None:
    password = getpass.getpass('odoo password:')
cl = erppeek.Client("https://odoo.exo.camptocamp.com:443",
        "openerp_prod_camptocamp", login, password)
my_id = cl.search("hr.employee", [["login", "=", login]])[0]

employee = cl.read("hr.employee", [my_id], ["user_id"])
employee_id = employee[0]['user_id'][0]

while True:
    ts = cl.search("hr_timesheet_sheet.sheet", [["user_id", "=", employee_id], ["date_from", "=", get_monday() ]])
    current_ts = ts[0]

    ts_sheetsheet = cl.read("hr_timesheet_sheet.sheet", [current_ts], ["timesheet_ids", "total_attendance", "name", "date_from", "date_to"])
    total_attendance_week = ts_sheetsheet[0]['total_attendance']

    tsday_id = cl.search("hr_timesheet_sheet.sheet.day", [["sheet_id", "=", current_ts], ["name", "=", datetime.now().strftime('%Y-%m-%d')  ]])
    tsday = cl.read("hr_timesheet_sheet.sheet.day", tsday_id, ["total_attendance"])

    todo = [ 7.7, 15.40, 23.10, 30.63, 38.5 ][datetime.now().weekday()]

    total_attendance_day = tsday[0]['total_attendance']
    output = ''
    if args.progress:
        output = u'[#[fg=cyan]'
        for i in range(0,30):
            done = (((total_attendance_week - (todo - 7.7)) / 7.7) * 30.0) > i
            if not done:
                output += u'#[default]'
                # ▓░
            output += u'=' if done else u'·'
        output += u'#[default]]'

    def to_minutes(st, display_plus=False):
        number = float(st)
        hours = int(number)
        minutes = int((number - hours) * 60)
        ret = u'#[fg=cyan]'
        if minutes < 0 or hours < 0:
            minutes = abs(minutes)
            hours = u'-%s' % unicode(abs(hours))
            ret = u''
        elif display_plus:
            hours = '+%s' % hours
        return u'%s%s:%s' % (ret, unicode(hours).zfill(2), unicode(minutes).zfill(2))

    output += u'#[fg=cyan] %s#[fg=colour12] / %s #[default]' % \
            (to_minutes(total_attendance_day), to_minutes(total_attendance_week - todo, display_plus=True))
    
    tf = codecs.open('%s/.current_ts' % os.getenv('HOME'), 'w', 'utf-8')
    tf.write(output)
    tf.close()

    sleep(60)
