#!/bin/sh
cd /root/eth-net-intelligence-api/
/usr/bin/pm2 start app.json
ALLOWED_HOSTS=`curl http://169.254.169.254/latest/meta-data/local-ipv4`:8546,ws.mewapi.io
ALLOWED_ORIGINS=https://localhost:8080,https://beta.myetherwallet.com,https://www.myetherwallet.com,https://*.mewbuilds.com
while true
do
    if [ ! `pgrep parity` ] ; then
        parity --author 0xDECAF9CD2367cdbb726E904cD6397eDFcAe6068D --jsonrpc-cors 'all' --jsonrpc-interface 'all' --jsonrpc-hosts 'all' --min-gas-price 1000000000 --no-persistent-txqueue --tx-queue-mem-limit 1024 --tx-queue-size 16384 --tx-time-limit 100 \
        --ws-interface 'all' --ws-origins $ALLOWED_ORIGINS --ws-hosts $ALLOWED_HOSTS --ws-max-connections 1000
    fi
    sleep 10
done