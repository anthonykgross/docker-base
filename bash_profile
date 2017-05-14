#!/bin/bash

export USER_UID=$(stat -c "%u" .)

echo "Starting with : $(id)"

if [ `grep -c '^docker:' /etc/passwd` -eq 0 ]; then
    if [ $USER_UID -ne 0 ]; then
        useradd -u $USER_UID docker
    fi
fi

if [ $USER_UID -eq 0 ]; then
    echo "You're root ! Use 'gosu' to change"
fi
