#!/bin/bash

# Script to set up a secure server with automatic updates, firewall rules, and monitoring.

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log actions
log() {
    echo "[INFO] $1"
}

log "Starting server setup..."

# Step 1: Update the package list and upgrade all packages
log "Updating system packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Step 2: Install necessary packages
log "Installing necessary packages: UFW, Fail2ban, unattended-upgrades, netdata"
sudo apt-get install -y ufw fail2ban unattended-upgrades netdata

# Step 3: Set up firewall rules with UFW
log "Setting up firewall rules..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Step 4: Configure automatic security updates
log "Configuring automatic security updates..."
sudo dpkg-reconfigure -plow unattended-upgrades

# Step 5: Set up Fail2ban to prevent brute force attacks
log "Setting up Fail2ban..."
cat <<EOF | sudo tee /etc/fail2ban/jail.local
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[sshd]
enabled = true
EOF

sudo systemctl restart fail2ban

# Step 6: Set up Netdata for system monitoring
log "Configuring Netdata..."
sudo systemctl start netdata
sudo systemctl enable netdata

# Step 7: Harden SSH configuration
log "Hardening SSH configuration..."
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Step 8: Disable unused services (example: disabling unused FTP service)
log "Disabling unused services..."
sudo systemctl disable vsftpd || true  # Only if the service exists

# Step 9: Create a non-root user with sudo privileges
read -p "Enter the username for the new sudo user: " username
sudo adduser $username
sudo usermod -aG sudo $username

# Step 10: Configure system limits for better performance
log "Configuring system limits..."
cat <<EOF | sudo tee /etc/security/limits.conf
* soft nofile 65535
* hard nofile 65535
EOF

# Step 11: Enable system resource monitoring (Netdata) via web interface
log "Netdata is available at http://your_server_ip:19999 for system monitoring."

log "Server setup complete!"
