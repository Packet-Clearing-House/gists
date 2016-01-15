#!/bin/bash 

########################################
# Seed your htpasswd file with random
# passwords for a specified user list.
# 
# mrones@pch.net 1.14.15
########################################

########################################
# Edit these config variables as needed
########################################

# put your users here
users=( mrjones guest1 guest2 guest3 guest4 guest5 )
# put the length of your password here
size=32
# put the destination of your htpasswd file here
file='/etc/nginx/htpasswd'
# put the path the htpasswd binary here
htpass='/usr/bin/htpasswd'

########################################
# Don't touch anything below this line!
########################################
echo -e "\nTHIS INFO WILL NOT BE SAVED!  RE-RUN IF YOU LOOSE THE PLAINTEXT"
echo -e "-----------------------------------------"
echo -e "These users and passwords will be put into the $file file."
echo -e "Each pasword will be $size characters long.\n"
echo -e "USER\t\tPASS"
echo -e "-----------------------------------------"
touch $file
for user in "${users[@]}"
do
        pass=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
        echo -e "$user\t\t$pass"
        $htpass -b $file $user $pass 2> /dev/null
done

