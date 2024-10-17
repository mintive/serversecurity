# Secure Linux Server Setup Script

## Overview

This bash script automates the process of setting up a secure Linux server. It includes steps for updating the system, setting up a firewall, configuring SSH, enabling automatic security updates, and installing system monitoring tools. The script is designed to work on Ubuntu/Debian systems and can be modified for other distributions.

## Features

- **Automatic updates**: Configures unattended-upgrades to keep your system secure.
- **Firewall (UFW)**: Sets up basic firewall rules to allow only necessary traffic (SSH, HTTP, HTTPS).
- **Fail2Ban**: Protects against brute force attacks by banning IP addresses with too many failed login attempts.
- **Netdata**: A lightweight monitoring tool that provides real-time system performance metrics via a web interface.
- **SSH Hardening**: Disables root login and password authentication for SSH to improve security.

## How to Use

### Prerequisites

- You need `sudo` privileges to run this script.
- This script is compatible with Ubuntu/Debian-based systems.

### Running the script

1. Download the script and make it executable:

    ```bash
    wget https://raw.githubusercontent.com/your-username/your-repo-name/main/server-setup.sh
    chmod +x server-setup.sh
    ```

2. Run the script:

    ```bash
    sudo ./server-setup.sh
    ```

3. Follow the prompts to create a new user and configure your server.

### Features Breakdown

- **Firewall (UFW)**: 
    - Denies all incoming connections except for SSH, HTTP, and HTTPS.
    - Allows all outgoing traffic.
  
- **Fail2Ban**: 
    - Configured to ban IP addresses after 3 failed login attempts for 1 hour.
  
- **SSH Hardening**: 
    - Disables password authentication for SSH.
    - Disables root login via SSH.
  
- **Netdata**: 
    - Provides a web-based dashboard for real-time system monitoring. Available at `http://your_server_ip:19999`.

### Customization

You can easily modify the firewall rules or extend the script by adding additional services or configurations according to your requirements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
