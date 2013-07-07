#!/usr/bin/python

import datetime
from dateutil.rrule import rrule, DAILY

dates=[x.strftime("%Y%m%d") for x in \
        rrule(DAILY, dtstart=datetime.date(2012, 1, 1), until=datetime.date(2012, 8, 1), byweekday=[0, 1,2,3,4])]

for d in dates:
    print d
