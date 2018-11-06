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
# When you run the script you should see a "302" when logging in:
#
#   Login result: 302
#
# After that, you should see a non-zero download size if your ACTION, TLD and
# DATE were found:
#
#   Download size: 5467
#
# For totally silent output, delete the two "--write-out" lines below
#
# Troubleshooting:
#
#  - A "Download result" of "401" means your USERNAME or PASSWORD is wrong
#  - A "Download result" of "404" means your ACTION is wrong
#  - If you get a small "Download size" with "Download result" of "200", check the
#       dns_stats.csv file for details
#

echo ".pch.net	TRUE	/	FALSE	1776643854	pch_nonce100	100" > cookies.txt

curl --silent \
     --cookie cookies.txt \
     --cookie-jar cookies.txt \
     -d login=USERNAME \
     -d password=PASSWORD \
     -d pch_nonce=100 \
     -d form_login=form_login \
     -o /dev/null \
     --write-out 'Please wait for download... ' \
     https://www.pch.net/user/login

curl --silent \
     --cookie cookies.txt \
     --cookie-jar cookies.txt \
     -o dns_stats.csv \
     --write-out 'Download result: %{http_code} - Download size: %{size_download}\n' \
     https://www.pch.net/api/anycast/ACTION/TLD/DATE
# NB trailing slash
