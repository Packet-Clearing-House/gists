#!/bin/bash

#
# Packet Clearing House
# c2018
# MIT License
# https://github.com/Packet-Clearing-House/gists
#

# To use this script you'll need to swap in your own USERNAME, PASSWORD, TLD,
# ACTION and DATE below. DATE should be YEARMONTHDAY format like "20160401".
#
#
# The two actions are "dns_stats_table_city" and "dns_stats_table_time":
#
#   By City: https://www.pch.net/api/anycast/dns_stats_table_city/TLD/DATE
#   By Time: https://www.pch.net/api/anycast/dns_stats_table_time/TLD/DATE
#
# You can log into this URL to see all your TLDs available, as well as view
# more help on which URLs to use:
#
#   https://www.pch.net/account/anycast/stats
#

echo ".pch.net	TRUE	/	FALSE	1776643854	pch_nonce100	100" > cookies.txt

wget --delete-after \
     --keep-session-cookies \
     --save-cookies cookies.txt \
     --load-cookies cookies.txt \
     --post-data 'login=USERNAME&password=PASSWORD&pch_nonce=100&form_login=form_login' \
     https://www.pch.net/user/login

wget --continue \
	--execute robots=off \
	--load-cookies cookies.txt \
	--no-parent \
	--output-document dns_stats.csv \
    https://www.pch.net/api/anycast/ACTION/TLD/DATE
# NB trailing slash
