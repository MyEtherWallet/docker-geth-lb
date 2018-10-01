#!/bin/bash
cd /root/eth-net-intelligence-api/
/usr/bin/pm2 start app.json
while true
do
if [ ! `pgrep parity` ] ; then
	parity --author 0xDECAF9CD2367cdbb726E904cD6397eDFcAe6068D --rpccorsdomain '*' --rpcaddr '0.0.0.0' --jsonrpc-hosts 'all' --min-gas-price 1000000000 --tx-queue-no-unfamiliar-locals --no-persistent-txqueue --tx-queue-size 16384
fi
sleep 10
done