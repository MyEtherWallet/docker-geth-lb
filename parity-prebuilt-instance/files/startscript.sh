#!/bin/bash
cd /root/eth-net-intelligence-api/
/usr/bin/pm2 start app.json
while true
do
if [ ! `pgrep parity` ] ; then
	parity --jsonrpc-server-threads 8 --jsonrpc-threads 64 --author 0xDECAF9CD2367cdbb726E904cD6397eDFcAe6068D --jsonrpc-cors 'all' --jsonrpc-interface 'all' --jsonrpc-hosts 'all' --min-gas-price 1000000000 --no-persistent-txqueue --tx-queue-mem-limit 1024 --tx-queue-size 16384 --tx-time-limit 100
fi
sleep 10
done