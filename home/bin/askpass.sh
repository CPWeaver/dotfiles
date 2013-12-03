#!/bin/sh

sleep 10
export SSH_ASKPASS=/usr/bin/ksshaskpass
ssh-add < /dev/null
