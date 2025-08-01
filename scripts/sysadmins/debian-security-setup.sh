#!/bin/bash
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Script need to run with sudo"
        exit 1
    fi 

function install_package() {
    apt update && apt upgrade -y
    apt install nftables fail2ban openssh-server -y
}

function setup_ssh(){
    systemctl enable sshd
    sed -i 's/^#\?Port .*/Port 22/' /etc/ssh/sshd_config
    sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
    sed -i 's/^#\?MaxAuthTries .*/MaxAuthTries 2/' /etc/ssh/sshd_config
    sed -i 's/^#\?PermitEmptyPasswords .*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
}

function setup_fail2ban(){
    systemctl enable fail2ban
    touch /etc/fail2ban/jail.local
    cat <<EOF > /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
maxretry = 2
findtime = 600
bantime = 1800
EOF

    systemctl restart fail2ban


function setup_nftables_rules(){
    
}


echo "Debian Security Setup"
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


