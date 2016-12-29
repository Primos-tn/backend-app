curl -H "Content-Type: application/json" \
 -X POST -d '{"account": {   "email":"houssem.fathallah@protonmail.com",  "username" : "from_mobile",    "password":"123456789",  "password":"123456789"} }'  \
 http://localhost:3000/api/v1/accounts/create

curl -H "Content-Type: application/json" \
 -X POST -d '{"account": {   "email":"fathallah.houssem@protonmail.com",  "username" : "from_mobile",    "password":"123456789",  "password":"123456789"} }'  \
 http://localhost:3000/api/v1/accounts/create


 curl -H "Content-Type: application/json" \
 -X POST -d '{"account": {   "login":"houssem.fathallah@protonmail.com",   "password":"123456789"}}'  \
 http://localhost:3000/api/v1/accounts/login


 curl -H "Content-Type: application/json" \
 -X POST -d '{"account": {   "login":"fathallah.houssem@protonmail.com",   "password":"123456789"}}'  \
 http://localhost:3000/api/v1/accounts/login


 curl \
  -H "Authorization: Token token=vPCnlglK+TRcgwzRF6DK981q0qabfiz/BzF28nhAvlwKNJIk5HT+Yz/LKMU414FYRMLld9WgdgU20lvgsQKR2A==" \
 -H "Content-Type: application/json" \
  http://localhost:3000/api/v1/products/2/coupons

