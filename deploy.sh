#!/usr/bin/env bash
sudo apt update && sudo apt install nodejs npm
# Install pm2 which is a production process manager for Node.js with a built-in load balancer
sudo npm install -g pm2
# stop any instance of our application running currently
pm2 stop simple-app
# change director into folder where application is dowloaded
cd Simple-App/
# install application dependecies and 
npm install
echo $PRIVATE_KEY > privatekey.pem
echo $SERVER > server.crt
# start the application with the process name example_app using pm2
pm2 start ./bin/www --name simple-app