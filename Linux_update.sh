#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/update_error.log

# Function to log and display messages
log_and_display() {
    local message=$1
    echo "$message" | tee -a $logfile
}

# Function to log errors
log_error() {
    local message=$1
    echo "$message" | tee -a $errorlog >&2
}

if grep -q "arch" $release_file; then 
    log_and_display "Starting update for Arch Linux..."
    
    # Arch Linux update
    if sudo pacman -Syu 2>&1 | tee -a $logfile | tee -a $errorlog >&2; then
        log_and_display "Arch Linux update completed successfully."
    else
        log_error "An error occurred during the Arch Linux update. Please check the $errorlog file."
    fi
elif grep -q "Fedora" $release_file; then
    log_and_display "Starting update for Fedora..."
    
    # Fedora update
    if sudo dnf update -y 2>&1 | tee -a $logfile | tee -a $errorlog >&2; then
        log_and_display "Fedora update completed successfully."
    else
        log_error "An error occurred during the Fedora update. Please check the $errorlog file."
    fi
else
    log_and_display "Unsupported OS. This script only supports Arch Linux and Fedora."
fi
