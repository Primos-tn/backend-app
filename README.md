# Disclaimer 
This code is no longer maintained

# Restart fusion server
### kill all 
`sudo fuser -k 80/tcp`
### start 
sudo service service nginx start

# Configuration 

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Phusion
    https://www.phusionpassenger.com/library/install/nginx/install/oss/trusty/

    ```

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    sudo apt-get install -y apt-transport-https ca-certificates


    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update


    sudo apt-get install -y nginx-extras passenger

    ```
# Edit /etc/nginx/nginx.conf and uncomment include /etc/nginx/passenger.conf;. For example, you may see this:

    # include /etc/nginx/passenger.conf;

    Remove the '#' characters, like this:

    include /etc/nginx/passenger.conf;


* ...


### precompile

### git ls-files --deleted -z | xargs -0 git rm 


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
# Secrets 
### set up env
env :
    config/<env>.rb

### file secrets
<env> :
    secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

### database url

### rails migrate
