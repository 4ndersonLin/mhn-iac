#!/bin/bash
apt update && apt upgrade -y
apt install -y git expect

export LC_ALL=C
export TERM="xterm-256color"

cd /opt
git clone https://github.com/pwnlandia/mhn.git

export PASSWORD_LEGTH="16"
export SUPERUSER_EMAIL="root@localhost"
export SUPERUSER_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $PASSWORD_LEGTH ; echo '')
export SERVER_BASE_URL="http://localhost:80"
export HONEYMAP_URL="http://localhost:3000"
export DEBUG_MODE="n"
export SMTP_HOST="localhost"
export SMTP_PORT="25"
export SMTP_TLS="n"
export SMTP_SSL="n"
export SMTP_USERNAME=""
export SMTP_PASSWORD=""
export SMTP_SENDER=""
export MHN_LOG="/var/log/mhn/mhn.log"

sed -i "s|SUPERUSER_EMAIL|"$SUPERUSER_EMAIL"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SUPERUSER_PASSWORD|"$SUPERUSER_PASSWORD"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SERVER_BASE_URL|"$SERVER_BASE_URL"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|HONEYMAP_URL|"$HONEYMAP_URL"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|DEBUG_MODE|"$DEBUG_MODE"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_HOST|"$SMTP_HOST"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_PORT|"$SMTP_PORT"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_TLS|"$SMTP_TLS"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_SSL|"$SMTP_SSL"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_USERNAME|"$SMTP_USERNAME"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_PASSWORD|"$SMTP_PASSWORD"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|SMTP_SENDER|"$SMTP_SENDER"|g" /opt/mhn/scripts/docker_expect.sh
sed -i "s|MHN_LOG|"$MHN_LOG"|g" /opt/mhn/scripts/docker_expect.sh
sed -i '36i\expect "Would you like to add MHN rules to UFW?"' /opt/mhn/scripts/docker_expect.sh
sed -i '37i\send "n\r"' /opt/mhn/scripts/docker_expect.sh
sed -i '31s/$/ --no-block |head -n 3/' /opt/mhn/scripts/install_mongodb_ub16.sh


chmod +x /opt/mhn/scripts/docker_expect.sh
sudo expect /opt/mhn/scripts/docker_expect.sh

echo "=====Password====="
echo $SUPERUSER_PASSWORD
echo "=================="
