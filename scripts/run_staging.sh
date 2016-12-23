#!/bin/bash
dir=$PWD
echo ${dir}
file=$PWD"/env/.env.staging"

while IFS='' read -r line || [[ -n "$line" ]]; do
    export "$line"
done < "$file"
printenv
export RAILS_ENV=staging
# rails s
rake configure:all