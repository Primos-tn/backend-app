#!/usr/bin/env bash
if [ -z $1 ]; then
    echo "no file provided"
    exit 1
fi
input=$PWD'/env/.env.staging'
echo $input
while IFS= read -r var
do
  echo "$var"
done < "$input"