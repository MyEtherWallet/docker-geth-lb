#!/bin/bash
cd /root/eth-net-intelligence-api/
/usr/bin/pm2 start app.json
while true
do
if [ ! `pgrep parity` ] ; then
	parity --geth --cache=4096 --rpcaddr '0.0.0.0' --rpccorsdomain '*'
fi
sleep 10
done