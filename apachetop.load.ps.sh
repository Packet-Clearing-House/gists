#!/usr/bin/env bash

#######################################################
# Run this script every minute to easily correlate
# a high load to specific IP and directory. Sample
# output is:
# 30/Nov/2017:00:13 LOAD_1="88.05" LOAD_5="76.62" LOAD_15="42.46" TOP_APACHE="29 127.0.0.1 GET /resources" TOP_PROCESS="112 /usr/sbin/httpd"
#  DATE    LOAD AVG: 1 MIN          5 MIN           15 MIN        TOP REQUEST WITH COUNT IP METHOD TOP DIR    TOP PROCESS FROM PS W/ COUNT
#
# Run this in cron via:
# * * * * * /root/apachetop.load.ps.sh >> /var/log/httpd/apachetop.load.ps_log
#######################################################

# get the date from prior minute as the current minute may not have been written to disk yet
date=`date --date='1 minutes ago' +%d/%b/%Y:%R`
apache=`grep $date /var/log/httpd/ssl_access_log |grep -v '::1'|cut -d' ' -f1,6,7|cut -d'/' -f 1,2|sort|uniq -c|sort -nr|head -n 1|tr '"' ' '|xargs`
load1=`uptime|cut -d' ' -f14|tr ',' ' '|xargs`
load5=`uptime|cut -d' ' -f15|tr ',' ' '|xargs`
load15=`uptime|cut -d' ' -f16|tr ',' ' '|xargs`
process=`ps xa|cut -d':' -f 2|cut -d' ' -f 2|sort|uniq -c|sort -rn|head -n 1|tr '\n' ' '|xargs`

# echo the final results
echo $date" LOAD_1="\"$load1\"" LOAD_5="\"$load5\"" LOAD_15="\"$load15\"" TOP_APACHE="\"$apache\"" TOP_PROCESS="\"$process\"
