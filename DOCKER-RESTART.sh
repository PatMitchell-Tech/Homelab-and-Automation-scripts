#!/bin/bash

# Define ANSI color codes
CYAN="\033[1;36m"
RESET="\033[0m"

animate_message() {
    local message=$1
    local duration=$2
    echo -n "$message"
    (
        while true; do
            for dots in "." ".." "..."
            do
                echo -ne "\r$message${CYAN}${dots}${RESET}   "
                sleep 0.5
            done
        done
    ) &
    local anim_pid=$!
    sleep "$duration"
    kill $anim_pid > /dev/null 2>&1
    wait $anim_pid 2>/dev/null
    echo -e "\n"  # <-- line break after animation ends
}

# Animated message for restarting services
animate_message "All of your services are restarting for maintenance" 5

# Restart all Docker containers
sudo docker restart $(sudo docker ps -aq)
echo ""

# Animated message for loading services
animate_message "Loading your current Docker services" 5

# Show Docker containers
sudo docker ps -a
