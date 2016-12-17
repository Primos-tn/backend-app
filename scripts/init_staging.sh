#!/bin/bash
dir=$PWD
echo ${dir}
file="$dir/.env.staging"

while IFS='' read -r line || [[ -n "$line" ]]; do
    export "$line"
done < "$file"
printenv
export RAILS_ENV=staging
rails db:environment:set RAILS_ENV=staging
rake db:drop db:create db:migrate
rake db:seed
rake configure:all