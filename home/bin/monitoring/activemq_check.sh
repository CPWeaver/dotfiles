#!/bin/bash

if [[ ${#} < 2 ]]; then
  echo "usage: $(basename ${0}) <jmxHost> <queueName> [warnSize] [critSize] [critAge] [jmxPort]"
  echo 
  echo "queueName can be an actual queue name or one of the following shortcuts:"
  echo "	DLQ -> ActiveMQ.DLQ"
  echo "	FMQ -> FAILED_EVENT_QUEUE"
  echo "	SMQ -> SMALL_EVENT_QUEUE"
  echo "	LMQ -> LARGE_EVENT_QUEUE"
  echo
  exit 3
fi

jmxHost=${1}
queueName=${2}
warnSize=${3:-5}
critSize=${4:-5}
critAge=${5:-1800}
port=${6:-1099}
cmdLineJMXJar=$(dirname $0)/cmdline-jmxclient-0.10.3.jar
#cmdLineJMXJar=/home/cweaver/bin/monitoring/cmdline-jmxclient-0.10.3.jar

checkQueueName=""
case $queueName in
  FMQ) 
    checkQueueName="FAILED_EVENT_QUEUE"
    ;;
  SMQ)
    checkQueueName="SMALL_EVENT_QUEUE"
    ;;
  LMQ)
    checkQueueName="LARGE_EVENT_QUEUE"
    ;;
  DLQ)
    checkQueueName="ActiveMQ.DLQ"
    ;;
  *)
    checkQueueName="${queueName}"
    ;;
esac

let "critAgeMinutes = ${critAge} / 60"

queueSize=$(java -jar ${cmdLineJMXJar} - ${jmxHost}:${port} \
  org.apache.activemq:BrokerName=${jmxHost},Type=Queue,Destination=${checkQueueName} QueueSize 2>&1)
if [[ -z $(echo ${queueSize} | grep QueueSize) ]]; then
  echo "OK - ${queueName} does not exist"
  exit 0
fi

queueSize=${queueSize//*QueueSize: /}

now=$(date +%s)
messages=$(java -jar ${cmdLineJMXJar} - ${jmxHost}:${port} \
  org.apache.activemq:BrokerName=${jmxHost},Type=Queue,Destination=${checkQueueName} browseAsTable 2>&1 | \
  grep JMSTimestamp | sed -e 's/.*: //')


if [[ x${messages} == x ]]; then
  # no messages on the queue, all is well
  oldest=${now}
else
  oldest=$(while read d; do
      date -d "$d" +%s
    done <<EOF | sort | head -n 1
${messages}
EOF
)
fi

if [[ $(expr ${now} - ${oldest}) -gt ${critAge} ]]; then
  echo "CRIT - ${queueName}: message(s) older than ${critAgeMinutes} frak'n minutes"
  exit 2
elif [[ ${queueSize} -gt ${critSize} ]]; then
  echo "CRIT - ${queueName}: QueueSize > ${critSize}"
  exit 2
elif [[ ${queueSize} -gt ${warnSize} ]]; then
  echo "WARN - ${queueName}: QueueSize > ${warnSize}"
  exit 1
else
  echo "OK - ${queueName} is within tolerance"
  exit 0
fi
