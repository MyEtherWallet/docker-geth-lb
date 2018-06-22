#!/bin/sh
backupStart="/root/BACKUP-START"
clientName="geth"
dataDir="/root/.ethereum"
backupDir="$dataDir/backups"
chainDir="$dataDir/geth/chaindata"

/usr/sbin/crond -f -l 8 &

while true
do

if [ -e "$backupStart" ] ; then
	echo "$backupStart found. Starting backup."
	killall -HUP geth
	current_time=$(date "+%Y.%m.%d-%H.%M.%S")
	mkdir -p $backupDir
	tar \
        --create \
        --no-check-device \
        --file="$backupDir/$clientName-$current_time.tar" \
        --listed-incremental="$backupDir/index" \
        $chainDir
	rm $backupStart
	echo "Backup done $backupStart deleted."
fi

if [ ! `pgrep geth` ] ; then
	echo "Starting geth!"
	geth \
	--cache=512 \
	--rpcvhosts='*' --rpc --rpcaddr '0.0.0.0' --rpccorsdomain '*' \
	--txpool.accountslots=256 --txpool.globalslots=20000 --txpool.accountqueue=256 --txpool.globalqueue=20000 &
fi
sleep 10
done