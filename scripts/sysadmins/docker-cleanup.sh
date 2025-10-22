#!/bin/bash

set -euo pipefall

help(){
  cat << 'EOF'
  Usage guide: docker-cleanup.sh
  Description: This script will remove all docker containers, images, volumes and networks
  Options:
    -h      Display this message
    -a      Remove all docker stopped containers, images, volumes and networks
    -c      Remove all docker containers
    -v      Remove all docker volumes
    -n      Remove all docker networks
    -s      Output docker container sort by size
}

echo "Docker cleanup script"
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

while getopts "hacvns" opt; do
  case $opt in
    h)
      help
      exit 0
      ;;
    a)
      remove_all=true
      ;;
    c)
      remove_containers=true
      ;;
    v)
      remove_volumes=true
      ;;
    n)
      remove_networks=true
      ;;
    s)
      sort_by_size=true

