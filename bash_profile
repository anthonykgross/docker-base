#!/bin/bash

export VOLUME_USER_UID=$(stat -c "%u" .)
export VOLUME_USER_GID=$(stat -c "%g" .)

export USER_UID=$(id -u)
export USER_GID=$(id -g)

echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "User      : $(id)"

function help {
    echo " "
    echo "Commands:"
    echo "  'help'               : This command."
    echo "  'gosu docker bash'   : Use the same user as your local one."
    echo " "
}

function isRoot {
    if [ $1 -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

function groupname {
    getent group $1 | cut -d: -f1
}

if ! isRoot $VOLUME_USER_UID ; then
    if [ $(id -u docker) -ne $VOLUME_USER_UID ]; then
        usermod -u $VOLUME_USER_UID docker
    fi
    if [ $(id -g docker) -ne $VOLUME_USER_GID ]; then
        usermod -g $VOLUME_USER_GID docker
    fi
    echo "Workspace : uid=$VOLUME_USER_UID(docker) gid=$VOLUME_USER_GID(`groupname $VOLUME_USER_GID`)"
else
    echo "Workspace : uid=$VOLUME_USER_UID(root) gid=$VOLUME_USER_GID(`groupname $VOLUME_USER_GID`)"
fi

if isRoot $USER_UID; then
    echo ""
    echo "[ WARNING ] You're root ! Use 'gosu' to change"
fi

echo ""
echo "Documentation : https://github.com/anthonykgross/docker-base/tree/master"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"