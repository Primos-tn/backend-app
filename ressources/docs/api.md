
# **Primos api docs**


# version `V1`

# API hosts

**Production** : `https://www.primos.tn/api/v1/`

**Staging** : `https://www.staging.primos.tn/api/v1/`


## Accounts 
---


### - Registration

  Create or register a new user 

**Path** : `/accounts/register`
**Method:**`POST`
**Data Params**
* Required:
    `username=[string]`
    `email=[string]`
    `password=[string]`
    `age=[integer]`

**Response**
    
* **Success Response:**
  **Code:** 200 
  **Content:** `{ id : 12 }`
 
* **Error Response:**
  **Code:** 500 ERROR
    **Content:** `{ 'error' : "duplicate" }`
 
  **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Email Invalid" }`


**Sample Call:**
  ```
        curl -X POST \
        -d {username : 'test_api', password : 'test_api_pass', age : 15 , email : 'test@api.com' }\
        <API_HOST>/accounts/register
   ``` 

### - Login

  Login to get an access token  

**Path** : `/accounts/login`
**Method:**`POST`
**Data Params**
* Required:
    `username|email=[string]`
    `password=[string]`

**Response**
    
* **Success Response:**
  **Code:** 200 
  **Content:** `{ id : 12, access_token : 'SGQGJQRETQGJ' }`
 
* **Error Response:**

  **Code:** 401 UNAUTHORIZED
    **Content:** `{ 'error' : "Unauthorized" }`
 
  **Code:** 422 UNPROCESSABLE ENTRY
    **Content:** `{ error : "Invalid credentials" }`


**Sample Call:**
  ```
        curl -X POST \
        -d {username : 'test_api', password : 'test_api_pass'}\
        <API_HOST>/accounts/login
   ``` 

### - Register push token 

  Register a device push token 

**Path** : `/accounts/register-push`
**Authorisation:**   `Authorization: token <ACCESS_TOKEN>`
**Method:**`POST`
**Data Params**
* Required:
    `token=[string]`
    `uuid=[string]`

**Response**
    
* **Success Response:**
  **Code:** 200 
  **Content:** `{ id : 12, acess_token : 'SGQGJQRETQGJ' }`
 
* **Error Response:**

  **Code:** 401 UNAUTHORIZED
    **Content:** `{ 'error' : "Unauthorized" }`
 
  **Code:** 422 UNPROCESSABLE ENTRY
    **Content:** `{ error : "Invalid credentials" }`


**Curl Call:**
    
 Get products 
 
```
  curl  http://localhost:3000/api/v1/products -H 'Authorization:Token token="vPCnlglK+TRcgwzRF6DK981q0qabfiz/BzF28nhAvlwKNJIk5HT+Yz/LKMU414FYRMLld9WgdgU20lvgsQKR2A=="' -d '{"push_token" : {"value" : "ccc", "platform" : "android", "uuid" : "74"}}' -H "Accept:application/json" -H "Content-Type:application/json"

   ```  


  Register push 
  
  ```
  curl -X POST http://localhost:3000/api/v1/accounts/register-push -H 'Authorization:Token token="vPCnlglK+TRcgwzRF6DK981q0qabfiz/BzF28nhAvlwKNJIk5HT+Yz/LKMU414FYRMLld9WgdgU20lvgsQKR2A=="' -d '{"push_token" : {"value" : "ccc", "platform" : "android", "uuid" : "74"}}' -H "Accept:application/json" -H "Content-Type:application/json"

   ```  
   ```
  curl  http://localhost:3000/api/v1/products/3/coupons \
  -H 'Authorization:Token token="vPCnlglK+TRcgwzRF6DK981q0qabfiz/BzF28nhAvlwKNJIk5HT+Yz/LKMU414FYRMLld9WgdgU20lvgsQKR2A=="' 

   ``` 
   
  (C) Primos 2017
