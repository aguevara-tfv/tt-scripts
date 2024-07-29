#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo -e '\033[31mYou must run this script with sudo\033[0m'
    exit 1
fi

echo 'Restarting network'
systemctl restart NetworkManager

echo 'Reloading /etc/sysctl.conf'
sysctl -p

echo 'Waiting 10 seconds'
sleep 10

echo 'Displaying status'
nmcli general status

echo -e '\033[32mDONE\033[0m'

