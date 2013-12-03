#!/bin/bash
FILE=/usr/local/tomcat/logs/cc_activemq_failure.out

if [ -f $FILE ] && [-s $FILE ] ;
then
   echo "ActiveMQ Failure logs exist!"
   exit 1
else
   echo "OK - ActiveMQ is Happy."
   exit 0
fi
