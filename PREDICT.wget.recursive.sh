#!/bin/bash

# Special thanks to Francis O'Donovan francis.odonovan@bostonfusion.com

# To use you'll need to swap in your own USERNAME and PASSWORD below.
# As well, be sure to specify the correct URL you're looking to download

wget --delete-after \
     --keep-session-cookies \
     --save-cookies cookies.txt \
     --post-data 'username=USERNAME&password=PASSWORD&duration=20' \
     https://prefix.pch.net/applications/login/index.php

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
