#!/bin/sh

FOLDER_NAME=$(date +'%Y-%m-%d-%H-%M-%S')

#TODO: read environment variables
AWS_SSH='ssh ec2-54-163-133-130.compute-1.amazonaws.com'
AZURE_SSH='ssh -i ~/.ssh/azure_id_rsa lei@52.224.164.216'
#execute export on aws
sed 's/FOLDER_NAME/'$FOLDER_NAME'/' export.sh | $AWS_SSH

#download files from aws to local
scp ubuntu@ec2-54-163-133-130.compute-1.amazonaws.com:/home/ubuntu/workspace/$FOLDER_NAME/*.json .

#update local files to azure
echo 'mkdir /home/lei/workspace/'$FOLDER_NAME | $AZURE_SSH
#TODO: ip/key to variable
scp -i ~/.ssh/azure_id_rsa ./*.json lei@52.224.164.216:/home/lei/workspace/$FOLDER_NAME/

#execute import on azure
sed 's/FOLDER_NAME/'$FOLDER_NAME'/' import.sh | $AZURE_SSH