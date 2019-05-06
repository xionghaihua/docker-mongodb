#!/bin/bash

if [ ! -f /tmp/.mongodb_password_set ]; then

        /tmp/set_mongodb_password.sh

fi


if [ "$AUTH" == "yes" ]; then

    export mongodb='/opt/apply/mongodb/bin/mongod --nojournal --auth --logappend --dbpath /data/db --maxConns 3000  --bind_ip_all --unixSocketPrefix /data/db --logpath "/data/log//mongodb.log"'
else
    export mongodb='/opt/apply/mondodb/bin/mongod --nojournal --logappend --dbpath /data/db --maxConns 3000  --bind_ip_all  --unixSocketPrefix /data/db  --logpath "/data/log//mongodb.log"'
fi



if [ ! -f /data/db/mongod.lock ]; then

    eval $mongodb
else
    export mongodb=$mongodb
    rm /data/db/mongod.lock
    mongod --dbpath /data/db --logappend --maxConns 3000 --bind_ip_all --nojournal  --unixSocketPrefix /data/db --logpath "/data/log//mongodb.log"
fi


