#!/bin/bash
cd /root/eth-netstats
while true
do
if [ ! `pgrep node` ] ; then
	npm start
fi
sleep 10
done