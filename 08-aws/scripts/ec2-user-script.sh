#!/usr/bin/env bash

# Set DEBIAN_FRONTEND to non-interactive to avoid prompts during apt operations
# export DEBIAN_FRONTEND=noninteractive

# Update package list and install Nginx
sudo apt update
# sudo apt upgrade -y
sudo apt install -y nginx htop net-tools git tmux vim unzip
sudo apt clean cache

# Get the EC2 metadata token
export TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Retrieve instance metadata
export META_INST_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id -H "X-aws-ec2-metadata-token: $TOKEN")
export META_INST_TYPE=$(curl http://169.254.169.254/latest/meta-data/instance-type -H "X-aws-ec2-metadata-token: $TOKEN")
export META_INST_AZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone -H "X-aws-ec2-metadata-token: $TOKEN")
export HOST_NAME=$(hostname)
export U_NAME=$(uname -a)

# Create a directory for the site and navigate to it
sudo mkdir -p /var/www/html
cd /var/www/html

# Create the index.html file with instance metadata
cat <<EOF | sudo tee index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AWS Instance Metadata</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }
    h1 {
      color: #333;
      text-align: center;
    }
    .content {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
    }
    p {
      font-size: 1.2em;
      color: #333;
    }
    b {
      color: #0056b3;
    }
    code {
      background-color: #f0f0f0;
      padding: 5px;
      font-size: 1.1em;
      border-radius: 4px;
    }
  </style>
</head>
<body>

  <h1>This is an AWS Instance Yo!</h1>

  <div class="content">
    <p><b>Name:</b> <code>${HOST_NAME}</code></p>
    <p><b>OS:</b> <code>${U_NAME}</code></p>
    <p><b>Instance ID:</b> <code>${META_INST_ID}</code></p>
    <p><b>Instance Type:</b> <code>${META_INST_TYPE}</code></p>
    <p><b>Instance AZ:</b> <code>${META_INST_AZ}</code></p>
  </div>

</body>
</html>
EOF

# Start Nginx
sudo systemctl start nginx
sudo systemctl enable nginx
