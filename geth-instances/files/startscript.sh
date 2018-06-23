#!/bin/sh
while true
do
if [ ! `pgrep geth` ] ; then
	geth --ethstats "$INSTANCE_NAME:$WS_SECRET@$WS_SERVER:3000" --cache=512 --rpcvhosts='*' --rpc --rpcaddr '0.0.0.0' --rpccorsdomain '*' --txpool.accountslots=256 --txpool.globalslots=20000 --txpool.accountqueue=256 --txpool.globalqueue=20000
fi
sleep 10
done