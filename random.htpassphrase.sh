#!/bin/bash


#
# Packet Clearing House
# c2016
# MIT License
# https://github.com/Packet-Clearing-House/gists
#

########################################
# Quickly create N passphrases of
# of Y words.  So to create 5 passphrases
# of 10 words long, run:
#
#    ./random.htpassphrase.sh 10 5
#
# mrjones@pch.net 3.17.16
########################################

if [[ $1 =~ ^[[:digit:]]+$ ]]; then
    COUNT=$1
else
    COUNT=4
fi
if [[ $2 =~ ^[[:digit:]]+$ ]]; then
    PHRASES=$2
else
    PHRASES=1
fi
DICT="/usr/share/dict/words"
if [ ! -f  "${DICT}" ] ; then
    echo "Sorry, dictionary not found! We expected one here: ${DICT}"
else
    e=1
    while [ $e -le "${PHRASES}" ]
    do
        i=1
        PHRASE=""
        while [ $i -le "${COUNT}" ]
        do
            WORD="'"
            while [[ $WORD == *"'"* ]]
            do
                WORD=`shuf -n 1 $DICT`
                WORD=$( echo "${WORD}" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
            done
            (( i++ ))
            PHRASE+=$WORD
        done
        (( e++ ))
        echo $PHRASE
    done
fi
