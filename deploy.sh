#!/bin/bash

echo "🚀 Starting Deployment for Go Application..."

if [ -d "git-deploy-automatically-golang" ]; then
    rm -rf git-deploy-automatically-golang || { echo "❌ Failed to delete the existing folder"; exit 1; }
fi


# Clone the repository if not already cloned
if [ -d "git-deploy-automatically-golang" ]; then
    echo "📥 Repository already cloned. Pulling the latest changes..."
    cd git-deploy-automatically-golang || { echo "❌ Failed to navigate to project directory"; exit 1; }
    git pull origin main || { echo "❌ Git pull failed"; exit 1; }
else
    echo "📥 Cloning the repository..."
    git clone https://github.com/dipto0079/git-deploy-automatically-golang.git || { echo "❌ Git clone failed"; exit 1; }
    cd git-deploy-automatically-golang || { echo "❌ Failed to navigate to project directory"; exit 1; }
fi

# Make the binary executable
chmod +x myapp

# Run the Go application
echo "🚀 Running the Go application..."
./myapp
