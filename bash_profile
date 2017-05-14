#!/bin/bash

export USER_UID=$(stat -c "%u" .)

echo "Starting with : $(id)"


function help {
    echo " "
    echo "Commands:"
    echo "  'help'               : This command."
    echo "  'gosu docker bash'   : Use the same user as your local one."
    echo " "
}

if [ $USER_UID -ne 0 ]; then
    usermod -u $USER_UID docker
fi

if [ $(id -u) -eq 0 ]; then
    echo "You're root ! Use 'gosu' to change"
fi

echo "Use 'help' to know more about this image"
