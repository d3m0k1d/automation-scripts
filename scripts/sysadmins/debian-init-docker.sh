#!/bin/bash
set -euo pipefail
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Script need to run with sudo"
        exit 1
    fi 
}

echo "Debian Docker Init Script"
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

check_root

apt-get update -y
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installed"

systemctl enable docker
systemctl start docker

echo "Docker started"