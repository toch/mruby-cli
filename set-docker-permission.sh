#!/bin/bash

CMD=$@

HOST_UID=`stat --printf=%u /home/mruby/code`
HOST_GID=`stat --printf=%g /home/mruby/code`

USER_NAME=`getent passwd $HOST_UID`
EXISTING_USER=$?
USER_NAME=`echo $USER_NAME | cut -d: -f1`

GROUP_NAME=`getent group $HOST_GID`
EXISTING_GROUP=$?
GROUP_NAME=`echo $GROUP_NAME | cut -d: -f1`

test $EXISTING_USER != 0 && usermod -u $HOST_UID mruby
test $EXISTING_GROUP != 0 && groupmod -g $HOST_GID mruby && usermod -g $HOST_GID mruby

chown -R $HOST_UID:$HOST_GID /home/mruby/code

test $EXISTING_USER != 0 && USER_NAME='mruby'

SHELL=/bin/bash sudo -EH -u $USER_NAME PATH=$PATH -s $CMD
