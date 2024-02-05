# Use Ubuntu as the base image
FROM ubuntu:latest

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Copy your website files
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
