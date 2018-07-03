#!/bin/sh
while true
do
if [ ! `pgrep geth` ] ; then
	geth --ethstats "$INSTANCE_NAME:$WS_SECRET@$WS_SERVER:3000" --cache=512 --rpcvhosts='*' --rpc --rpcaddr '0.0.0.0' --rpccorsdomain '*'
fi
sleep 10
done