
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto

./certbot-auto

./certbot-auto certonly --standalone -d staging.primos.tn -d www.staging.primos.tn

./certbot-auto certonly --standalone -d nenvi.me -d www.nenvi.me
