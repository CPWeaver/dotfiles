#!/bin/bash

echo `whoami` >> /tmp/wtf2
ssh-add
ssh dobra "echo hi! >> /tmp/wtf3" >> /tmp/wtf4
