#!/bin/bash

#
# Packet Clearing House
# c2016
# MIT License
# https://github.com/Packet-Clearing-House/gists
#

# Special thanks to Francis O'Donovan francis.odonovan@bostonfusion.com

# To use you'll need to swap in your own USERNAME and PASSWORD below.
# As well, be sure to specify the correct URL you're looking to download

echo ".pch.net	TRUE	/	FALSE	1776643854	pch_nonce100	100" > cookies.txt

wget --delete-after \
     --keep-session-cookies \
     --save-cookies cookies.txt \
     --load-cookies cookies.txt \
     --post-data 'login=USERNAME&password=PASSWORD&pch_nonce=100&form_login=form_login' \
     https://www.pch.net/user/login

wget --continue \
    --force-directories \
    --wait=10 \
    --random-wait \
    --execute robots=off \
    --load-cookies cookies.txt \
    --recursive \
    --no-parent \
    --convert-links \
    --force-directories \
    https://www.pch.net/resources/IARPA/Releases/release5labeled/
# NB trailing slash
