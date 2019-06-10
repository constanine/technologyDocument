#!/bin/bash
ps -ef | grep "redis-server"| grep -v grep|grep -v "redis-server-startup.sh"
if [ $?  -ne 0 ];
then
	./redis-server-controll.sh start
else
    echo "redis is running "
fi

