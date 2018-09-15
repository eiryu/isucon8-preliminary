#!/bin/sh

git pull
sudo mv /var/log/h2o/access.log /var/log/h2o/access.log-$(date "+%Y%m%d_%H%M%S")

sudo systemctl restart torb.nodejs.service
echo 'nodejs restarted'
sudo systemctl restart h2o.service
echo 'h2o restarted'
