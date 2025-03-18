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

echo "COPY . /usr/share/nginx/html" >> $DockerfileName
echo "WORKDIR /usr/share/nginx/html" >> $DockerfileName

sudo docker build -t simpleweb:1 .

sudo docker run -d -p 1212:80 simpleweb:1 
