#!/usr/bin/env bash

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.3.3


sudo apt-get install postgresql postgresql-contrib
-test sudo -i -u postgres
- psql
- \q
