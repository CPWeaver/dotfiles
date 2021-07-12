#!/bin/bash

while true
do
  docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | sort -k 2 -n
  test $? -gt 128 && break
done

