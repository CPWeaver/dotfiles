#!/bin/bash

echo -n "+ "
for file in ~/mail/readytalk/* 
do 
  box=$(basename "$file")
  echo -n "\"+$box\" "
done
echo -n "\"+temporary/search\" "
