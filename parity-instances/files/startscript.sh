#!/bin/sh
cd /root/eth-net-intelligence-api/
/usr/bin/pm2 start app.json
while true
do
if [ ! `pgrep parity` ] ; then
	parity --rpccorsdomain '*' --rpcaddr '0.0.0.0' --jsonrpc-hosts 'all' --tx-queue-no-unfamiliar-locals --no-persistent-txqueue
fi
sleep 10
done