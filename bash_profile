#!/bin/bash

export USER_UID=$(stat -c "%u" .)
export USER_GID=$(stat -c "%g" .)

echo "Starting with : $(id)"


function help {
    echo " "
    echo "Commands:"
    echo "  'help'               : This command."
    echo "  'gosu docker bash'   : Use the same user as your local one."
    echo " "
}

if [ `grep -c '^docker:' /etc/passwd` -eq 0 ]; then
    if [ $USER_UID -ne 0 ]; then
        useradd -u $USER_UID -g $USER_GID docker
    fi
fi

if [ $USER_UID -eq 0 ]; then
    echo "You're root ! Use 'gosu' to change"
fi

echo "Use 'help' to know more about this image"