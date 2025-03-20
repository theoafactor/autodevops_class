#!/bin/bash

source /home/astronaut/teachings/automate_devops/.env

echo $DOCKERHUB_USERNAME

DockerfileName="/home/astronaut/teachings/automate_devops/$DOCKERFILENAME"

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

sudo docker build -t $APP_NAME:$BUILD_VERSION .

## remove previously running Docker container
echo "Stopping any previuosly running container ... Please wait..."
sleep 2
sudo docker stop $APP_NAME 

echo "Running basic cleanups ..."
sleep 2
sudo docker rm $APP_NAME

echo "Running your container ... ---------------------------"
sudo docker run -d -p $APP_PORT:80 --name $APP_NAME $APP_NAME:$BUILD_VERSION 

echo "Application deployed successfully!"

## Tag the image
sudo docker tag $APP_NAME:$BUILD_VERSION $DOCKERHUB_USERNAME/$APP_NAME:$BUILD_VERSION

## Login to Docker
sudo docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD

### Push the image
sudo docker push $DOCKERHUB_USERNAME/$APP_NAME:$BUILD_VERSION

