#!/bin/bash

# To use this script you'll need to swap in your own USERNAME, PASSWORD, TLD
# and DATE below. DATE should be YEARMONTHDAY format like "20160401". TLD should have the
# leading dot like ".com".  Finally, be sure to keep the ampersands (&) escaped
# in the final URL

echo ".pch.net	TRUE	/	FALSE	1776643854	pch_nonce100	100" > cookies.txt

wget --delete-after \
     --keep-session-cookies \
     --save-cookies cookies.txt \
     --load-cookies cookies.txt \
     --post-data 'login=USERNAME&password=PASSWORD&pch_nonce=100&form_login=form_login' \
     https://www.pch.net/user/login

wget --continue \
	--wait=10 \
	--random-wait \
	--execute robots=off \
	--load-cookies cookies.txt \
	--no-parent \
	--output-document pch_query_counts.csv \
    https://prefix.pch.net/applications/anycast-dns/query_counts.php?mode=time\&tld=TLD\&date=DATE
# NB trailing slash
