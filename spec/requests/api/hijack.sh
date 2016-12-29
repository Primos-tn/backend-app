#!/usr/bin/env bash
# test for login
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products
#
#curl http://localhost:3000/api/v1/products


 ##
 curl \
  -H "Authorization: Token token=vPCnlglK+TRcgwzRF6DK981q0qabfiz/BzF28nhAvlwKNJIk5HT+Yz/LKMU414FYRMLld9WgdgU20lvgsQKR2A==" \
 -H "Content-Type: application/json" \
  http://localhost:3000/api/v1/products/2/coupons

##
 curl -H "Content-Type: application/json" \
 -X POST -d '{"account": {   "login":"fathallah.houssem@protonmail.com",   "password":"123456789"}}'  \
 http://localhost:3000/api/v1/accounts/login
