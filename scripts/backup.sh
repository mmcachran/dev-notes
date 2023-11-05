#!/usr/bin/env bash


# rsync -vrltD --stats --human-readable --exclude=node_modules --exclude=tmp ~/Projects/DEV /Volumes/Development/. | pv -lep -s 42 >/dev/null

##########################################################################
#Purpose: This script will take backup
##########################################################################

#Creating Variables 
src=/home/ubuntu/day5
dest=/home/ubuntu/backups
time=$(date +"%Y-%m-%d-%H-%M-%S")
backupfile=$dest/$time.tgz

#Taking Backup
echo "Taking backup on $time"
tar zcvf $backupfile --absolute-names $src

if [ ${?} -eq 0 ]
then
        echo "Backup Complete"
else
        exit 1
fi