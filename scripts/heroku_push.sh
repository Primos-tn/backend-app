#!/usr/bin/env bash
#if [ -z $1 ]; then
#    echo "no file provided"
#    exit 1
# fi
source=$PWD'/env/.env.staging'
all
while IFS= read -r var
do
  if [ ! -z "$var" ]; then
    #heroku config:add "$var"
    all=$all"$var "
  fi
done < "$source"
echo "$all"
heroku config:set $all