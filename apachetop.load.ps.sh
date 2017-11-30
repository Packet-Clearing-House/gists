#!/usr/bin/env bash

#######################################################
# Run this script every minute to easily correlate
# a high load to specific IP and directory. Sample
# output is:
# 30/Nov/2017:07:24 LOAD_1="1.60" LOAD_5="1.50" LOAD_15="1.35" APACHE_CNT="5" APACHE_IP="127.0.0.1" APACHE_DIR="/resources" PROCESS_CNT="25" PROCESS="/usr/sbin/httpd"
#
# Fields are:
#   LOAD_1 - load average for past 1 minute
#   LOAD_5 - load average for past 5 minutes
#   LOAD_15 - load average for past 15 minutes
#   APACHE_CNT - Count of top IP in the last minute
#   APACHE_IP - Top IP in the last minute
#   APACHE_DIR - Top Directory being hit by IP
#   PROCESS_CNT - Count of top process
#   PROCESS - Process name for count
#
# Run this in cron via:
# * * * * * /root/apachetop.load.ps.sh >> /var/log/httpd/apachetop.load.ps_log
#######################################################

# get the date from prior minute as the current minute may not have been written to disk yet
date=`date --date='1 minutes ago' +%d/%b/%Y:%R`
apache=`grep $date /var/log/httpd/ssl_access_log |grep -v '::1'|cut -d' ' -f1,6,7|cut -d'/' -f 1,2|sort|uniq -c|sort -nr|head -n 1|tr '"' ' '|xargs`
apache_count=`echo $apache|cut -d' ' -f 1`
apache_IP=`echo $apache|cut -d' ' -f 2`
apache_dir=`echo $apache|cut -d' ' -f 4`
load1=`uptime|cut -d' ' -f14|tr ',' ' '|xargs`
load5=`uptime|cut -d' ' -f15|tr ',' ' '|xargs`
load15=`uptime|cut -d' ' -f16|tr ',' ' '|xargs`
process=`ps xa|cut -d':' -f 2|cut -d' ' -f 2|sort|uniq -c|sort -rn|head -n 1|tr '\n' ' '|xargs`
process_count=`echo $process|cut -d' ' -f 1`
process_name=`echo $process|cut -d' ' -f 2`

# echo the final results
echo $date LOAD_1=\"$load1\" LOAD_5=\"$load5\" LOAD_15=\"$load15\" APACHE_CNT=\"$apache_count\" APACHE_IP=\"$apache_IP\" APACHE_DIR=\"$apache_dir\" PROCESS_CNT=\"$process_count\" PROCESS=\"$process_name\"
