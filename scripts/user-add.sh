#!/usr/bin/env bash

#Creating variables
user1=$1
user2=$2

#Creating Users
echo "Adding Users $user1 and $user2"
useradd -p test -m $user1
useradd -p test -m $user2

if [ ${?} -eq 0 ]
then
        echo "Users added successfully"
else
        exit 1
fi