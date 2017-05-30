#!/bin/bash

echo -n "+ "
for file in $1/*
do 
  box=$(basename "$file")
  echo -n "\"+$box\" "
done
echo -n "\"+temporary/search\" "
