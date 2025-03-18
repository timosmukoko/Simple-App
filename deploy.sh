#!/usr/bin/env bash

set -e  # Exit script on any error

echo "Updating system packages..."
sudo apt update && sudo apt install -y nodejs npm git

echo "Installing PM2 if not already installed..."
if ! command -v pm2 &> /dev/null; then
    sudo npm install -g pm2
fi

echo "Checking application directory..."
if [ -d "$HOME/Simple-App" ]; then
    echo "Application directory exists. Pulling latest changes..."
    cd "$HOME/Simple-App"
    git reset --hard origin/main  # Reset any local changes
    git pull origin main  # Fetch latest updates
else
    echo "Application directory not found! Cloning repository..."
    git clone https://github.com/timosmukoko/Simple-App.git "$HOME/Simple-App"
    cd "$HOME/Simple-App"
fi

echo "Installing application dependencies..."
npm install

echo "Setting up SSL certificates..."
echo "$PRIVATE_KEY" > privatekey.pem
echo "$SERVER" > server.crt
chmod 600 privatekey.pem server.crt  # Secure certificate files

echo "Restarting the application using PM2..."
pm2 restart simple-app || pm2 start ./bin/www --name simple-app

echo "🎉 Deployment complete!"
