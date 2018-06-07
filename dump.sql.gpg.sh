#!/usr/bin/env bash

# edit these two to match your environment
GPG_KEY="web dev"
MYSQL_SERVER="localhost"

echo ""
echo "What database would you like to use?"
read DB

echo ""
echo "If you want to specify table(s), do so here, otherwise hit return:"
read REPLY
if [[ -z "$REPLY" ]]
then
	TABLES=""
else
	TABLES=$REPLY
fi

echo ""
echo "What file name do you want to use to store your dump (don't add .sql or .gpg)?"
read REPLY
FILE="$REPLY.sql.gpg"

echo ""


eval "mysqldump --defaults-file=mysql-git-cron.conf -h $MYSQL_SERVER $DB $TABLES|gpg -e -r '$GPG_KEY' --trust-model always > $FILE"

echo "Done!  Data written to $FILE"
echo ""