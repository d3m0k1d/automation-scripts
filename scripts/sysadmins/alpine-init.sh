#!/bin/bash
set -euo pipefail
create_user() {
    apk add shadow
    echo "Please enter the username:"
    read username
    echo "Please enter the password:"
    read -s password
    useradd -m "$username"
    echo "$username:$password" | chpasswd
    echo "User $username created"
    if [ "$1" = "yes" ]; then
        apk add sudo
        sudo_group="wheel"
        adduser "$username" "$sudo_group"
        echo "User $username added to $sudo_group group (sudo access)"
    fi
}

enable_dcron() {
    echo "You want to add dcron to auto run commands? (y/n)"
    read add_dcron
    if [ "$add_dcron" = "y" ]; then
        rc-update add dcron default
        rc-service dcron start
        echo "dcron enabled and started"
    fi
}

enable_docker() {
    echo "You want to add docker to auto run? (y/n)"
    read add_docker
    if [ "$add_docker" = "y" ]; then
        rc-update add docker default
        rc-service docker start
        echo "docker enabled and started"
    fi
}

echo "Alpine Linux Init Script"
cat << 'EOF'

                               /$$             /$$           /$$                
                              |__/            | $$          | $$                
  /$$$$$$$  /$$$$$$$  /$$$$$$  /$$  /$$$$$$  /$$$$$$        | $$$$$$$  /$$   /$$
 /$$_____/ /$$_____/ /$$__  $$| $$ /$$__  $$|_  $$_/        | $$__  $$| $$  | $$
|  $$$$$$ | $$      | $$  \__/| $$| $$  \ $$  | $$          | $$  \ $$| $$  | $$
 \____  $$| $$      | $$      | $$| $$  | $$  | $$ /$$      | $$  | $$| $$  | $$
 /$$$$$$$/|  $$$$$$$| $$      | $$| $$$$$$$/  |  $$$$/      | $$$$$$$/|  $$$$$$$
|_______/  \_______/|__/      |__/| $$____/    \___/        |_______/  \____  $$
                                  | $$                                 /$$  | $$
                                  | $$                                |  $$$$$$/
                                  |__/                                 \______/ 
       /$$  /$$$$$$                 /$$$$$$  /$$         /$$         /$$        
      | $$ /$$__  $$               /$$$_  $$| $$       /$$$$        | $$        
  /$$$$$$$|__/  \ $$ /$$$$$$/$$$$ | $$$$\ $$| $$   /$$|_  $$    /$$$$$$$        
 /$$__  $$   /$$$$$/| $$_  $$_  $$| $$ $$ $$| $$  /$$/  | $$   /$$__  $$        
| $$  | $$  |___  $$| $$ \ $$ \ $$| $$\ $$$$| $$$$$$/   | $$  | $$  | $$        
| $$  | $$ /$$  \ $$| $$ | $$ | $$| $$ \ $$$| $$_  $$   | $$  | $$  | $$        
|  $$$$$$$|  $$$$$$/| $$ | $$ | $$|  $$$$$$/| $$ \  $$ /$$$$$$|  $$$$$$$        
 \_______/ \______/ |__/ |__/ |__/ \______/ |__/  \__/|______/ \_______/        
                                                                                
EOF
echo "https://github.com/d3m0k1d/automation-scripts"

echo "Please select the type of installation:"
echo "1. Minimal for use system as server"
echo "2. Python ready to deploy(+ base packages)"
echo "3. Docker ready to deploy(+ base packages)"
read choice

if [ "$choice" = "1" ]; then
    echo "You want to add a new user? (y/n)"
    read add_user
    if [ "$add_user" = "y" ]; then
        echo "You want to install sudo? (y/n)"
        read install_sudo
        if [ "$install_sudo" = "y" ]; then
            create_user "yes"
        else
            create_user "no"
        fi
    fi
    echo "Start to add base packages..."
    apk add nano vim curl wget ufw htop gzip dcron
    echo "Base packages added"
    enable_dcron
    echo "Script finished"
fi

if [ "$choice" = "2" ]; then
    echo "You want to add a new user? (y/n)"
    read add_user
    if [ "$add_user" = "y" ]; then
        echo "You want to install sudo? (y/n)"
        read install_sudo
        if [ "$install_sudo" = "y" ]; then
            create_user "yes"
        else
            create_user "no"
        fi
    fi
    echo "Start to add base packages..."
    apk add nano vim curl wget ufw htop gzip dcron python3 py3-pip python3-dev make
    echo "Python and base packages added"
    echo "You want to install uv(y/n)?"
    read install_uv
    if [ "$install_uv" = "y" ]; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    echo "You want to install docker(y/n)?"
    read install_docker
    if [ "$install_docker" = "y" ]; then
        apk add docker docker-compose-plugin
        enable_docker
    fi
    enable_dcron
    echo "Script finished"
fi

if [ "$choice" = "3" ]; then
    echo "You want to add a new user? (y/n)"
    read add_user
    if [ "$add_user" = "y" ]; then
        echo "You want to install sudo? (y/n)"
        read install_sudo
        if [ "$install_sudo" = "y" ]; then
            create_user "yes"
        else
            create_user "no"
        fi
    fi
    echo "Start to add packages..."
    apk add nano vim curl wget ufw htop gzip dcron docker docker-compose-plugin
    echo "Docker and base packages added"
    enable_docker
    enable_dcron
    echo "Script finished"
fi
