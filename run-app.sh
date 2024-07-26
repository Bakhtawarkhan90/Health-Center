#!/bin/bash

# Script to set up and run the Health-Center project on Ubuntu

# Update package list and install required packages
echo "Updating package list and installing required packages..."
sudo apt-get update
sudo apt-get install -y git docker.io curl apt-transport-https

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the Docker group
echo "Adding $USER to the Docker group..."
sudo usermod -aG docker $USER

# Set up Docker repository
echo "Setting up Docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

# Install Docker Compose V2
echo "Installing Docker Compose V2..."
sudo apt-get install -y docker-compose-plugin || {
  echo "Failed to install docker-compose-plugin. Attempting manual installation..."
  DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
  sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Verify Docker Compose V2 installation
docker compose version

# Clone the Health-Center repository
echo "Cloning the Health-Center repository..."
git clone https://github.com/Bakhtawarkhan90/Health-Center.git

# Navigate to the project directory
cd Health-Center

# Run Docker Compose to set up and start the containers
echo "Setting up and starting Docker containers with Docker Compose..."
docker compose up -d

# Check the status of the containers
echo "Checking the status of Docker containers..."
docker compose ps

echo "The Health-Center project has been set up and is running."
echo "You can access the web application at http://localhost:8000"
echo "Please log out and log back in for the Docker group membership to take effect."
