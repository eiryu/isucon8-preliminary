#!/bin/sh

git pull
sudo mv /var/log/h2o/access.log /var/log/h2o/access.log-$(date "+%Y%m%d_%H%M%S")
sudo mv /var/log/mariadb/slow.log /var/log/mariadb/slow.log-$(date "+%Y%m%d_%H%M%S")

\cp -f /home/isucon/torb/conf/my.cnf /etc/my.cnf 

sudo systemctl restart mariadb.service
echo 'mariadb restarted'
sudo systemctl restart torb.nodejs.service
echo 'nodejs restarted'
sudo systemctl restart h2o.service
echo 'h2o restarted'
