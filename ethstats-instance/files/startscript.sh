#!/bin/sh
cd /root/eth-netstats
while true
do
if [ ! `pgrep node` ] ; then
	node ./bin/www
fi
sleep 10
done