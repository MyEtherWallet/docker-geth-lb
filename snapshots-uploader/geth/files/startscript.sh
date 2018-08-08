#!/bin/sh
backupStart="/root/BACKUP-START"
clientName="geth"
dataDir="/root/.ethereum"
backupDir="$dataDir/backups"
chainDir="$dataDir/geth/chaindata"

/usr/sbin/crond -f -l 8 &

stopClient() {
  echo "Stopping $clientName daemon"
  supervisorctl stop geth
}

startClient() {
    echo "Starting $clientName daemon"
    supervisorctl start geth
}

while true
do

if [ -e "$backupStart" ] ; then
	echo "$backupStart found. Starting backup."
	stopClient
	current_time=$(date "+%Y.%m.%d-%H.%M.%S")
	mkdir -p $backupDir
	tar \
        --create \
        --no-check-device \
        --file="$backupDir/$clientName-$current_time.tar" \
        --listed-incremental="$backupDir/index" \
        $chainDir
    s3cmd --access_key $AWS_S3_ACCESS --secret_key $AWS_S3_SECRET sync $backupDir s3://$AWS_S3_BUCKET
	rm $backupStart
	rm "$backupDir/$clientName-$current_time.tar"
	echo "Backup done $backupStart deleted."
	startClient
fi

if [ ! `pgrep geth` ] ; then
	echo "Starting $clientName!"
	startClient
fi
sleep 10
done