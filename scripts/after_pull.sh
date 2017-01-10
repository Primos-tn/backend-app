#!/usr/bin/env bash

RAILS_ENV=<env> bunlde install
RAILS_ENV=<env> rake db:migrate


# in case and you must restart server

> netstat -tulpn | grep 3001 (pasenger server)
kill -9 id

> netstat -tulpn | grep 3001 (nginx bakup)
kill -9 id
