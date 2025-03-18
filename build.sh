#!/bin/bash

DockerfileName="Dockerfile"

if [[ -f $DockerfileName ]]
then
    echo "Dockerfile exists already"
    echo "FROM nginx:alpine" > $DockerfileName
else 
    ## file does not exist, create it
    echo "File does not exist..."
    echo "Creating it ..."
    sleep 3
    touch $DockerfileName
    echo "$DockerfileName file created ..."
    
    echo "FROM nginx:alpine" >> $DockerfileName    
fi

echo "RUN ls" >> $DockerfileName
