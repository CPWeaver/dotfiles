#!/bin/bash

docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

docker volume rm $(docker volume ls -q)

docker system prune 
