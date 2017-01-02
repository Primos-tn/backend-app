#!/usr/bin/env bash

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.3.3


sudo apt-get install postgresql postgresql-contrib
-test sudo -i -u postgres
- psql
- \q

# Imagemagick
sudo apt-get install imagemagick

# Redis See redis.installation.sh
!!!!

# sudo
# go works
# GET Repos
git clone https://github.com/tbouraoui/Primos.git -b master --single-branch
# install bundler
gem install bundler
# install native postgres
sudo apt-get install libpq-dev
#
bunlde install

# copy env files
scp /home/hassenfath/work/pingo/server/env/.env.staging  root@vps242181.ovh.net:/home/Primos/.env.staging
# get secret key
copy key to env/<env>.yml file

#  sudo -u postgres psql

# clear and set
RAILS_ENV=staging rake db:drop db:create db:migrate

#
RAILS_ENV=staging rake configure:all

# run now , -p 3001 for staging
RAILS_ENV=staging rails s
