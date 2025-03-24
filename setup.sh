#!/bin/bash

echo "🚀 Starting Deployment After Clone..."

# Navigate to the project directory
cd "$(dirname "$0")" || { echo "❌ Failed to enter project directory"; exit 1; }

# Install dependencies (if required)
echo "📦 Installing dependencies..."
go mod tidy

# Build the Go application
echo "🔨 Building the Go application..."
GOOS=linux GOARCH=amd64 go build -o myapp || { echo "❌ Build failed"; exit 1; }

# Move the binary to a global location (optional)
sudo mv myapp /usr/local/bin/ || { echo "❌ Failed to move binary"; exit 1; }

# Set permissions
chmod +x myapp

# Set up a systemd service (optional)
echo "🛠 Setting up systemd service..."
sudo tee /etc/systemd/system/myapp.service > /dev/null <<EOF
[Unit]
Description=Go Application
After=network.target

[Service]
User=$USER
WorkingDirectory=$(pwd)
ExecStart=$(pwd)/myapp
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the service
sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl restart myapp

echo "✅ Deployment completed! Your Go app is running."
sudo systemctl status myapp --no-pager
