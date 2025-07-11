#!/bin/bash

echo "Backup Script"
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

mkdir -p /home/$USER/backup
backup_name="backup_$(date +%Y-%m-%d-%H-%M-%S).tar.gz"

while true; do
    echo "Please enter the path to the directory you want to backup:"
    read path
    if [ -z "$path" ]; then
        echo "Path cannot be empty"
        echo "Please try again or use the ctrl+c to exit"
    fi
    if [ ! -d "$path" ]; then
        echo "Path does not exist"
        echo "Please try again or use the ctrl+c to exit"
    fi
    if [ -d "$path" ]; then
        tar -czvf /home/$USER/backup/$backup_name $path
        echo "Backup created at /home/$USER/backup/$backup_name"
        break
    fi
done