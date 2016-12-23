#!/bin/bash
dir=$PWD
echo ${dir}
file=$PWD"/env/.env.dev"

while IFS='' read -r line || [[ -n "$line" ]]; do
    export "$line"
done < "$file"
printenv
rails s
#rake configure:all