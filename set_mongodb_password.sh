#!/bin/bash
#set mongodb user and password
if [ -f /tmp/.mongodb_password_set ];then
	echo "mongodb password already set"
	exit 0
fi

/opt/apply/mongodb/bin/mongod --smallfiles --nojournal &

PASS=${MONGODB_PASS:-$(pwgen -s 12 1)}

#_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )
RET=1
while [[ RET -ne 0 ]]; do
   echo "=> Waiting for confirmation of MongoDB service startup"
   sleep 5
   mongo admin --eval "help" >/dev/null 2>&1
   RET=$?
done

echo "=> Creating an admin user with a $PASS password in MongoDB"
mongo admin --eval "db.createUser({user: 'admin', pwd: '$PASS', roles: [ 'userAdminAnyDatabase', 'dbAdminAnyDatabase' ]});"
mongo admin --eval "db.shutdownServer();"
echo "=> Done!"
touch /tmp/.mongodb_password_set
echo "mongo admin -u admin -p $PASS --host <host> --port <port>"



